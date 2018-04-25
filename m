Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Tn1vBnmfY/Sudfo3towvlbr+aUX6tmGTydu0BzjO1d2+ZAOacbLlwMSlQ+B92hgf4tvm7
ARC-Seal: i=1; a=rsa-sha256; t=1524652813; cv=none;
        d=google.com; s=arc-20160816;
        b=AVz/N378WMNbDq/FNopnT4uBIHSScBDghzoJP+kNVr9ktjAtTs+b6ujDEdtRJPTXF8
         gNqExBjgspiZ4ovfxPRNvJ7q505NauyW1svnKDgLj5uDpcYngocr5dbVRuIbmUThTNo9
         7PPz9++r2oVwExMXA9szFYRdTkS3lPrpukSasGb7lmZFmRFG0Ql7nNtUl2vH0M8/N0V4
         X3EKCwiczxI6l/9VfmnIxOSpa2wsFbWF4+PEZLTZhTJ9FmGcqcSk6yY9S8Jwol1Es02M
         i84latGLdIWelpLh11V7uPzkWyCDw8tzaWiv4JEYVXwtI1oXFHQqX5R/qlBBhXI1en7B
         R96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PXgcM7/3zbNAo7QIsPl8WGCKQI32APG/WwO08T8jT00=;
        b=TuPD3hCM1arJey9b7fA8HUbKsP5XPdOqDAB3xHXUlGUi1vOhdnoxEMR3F8QkHjxFBM
         psFSFEf04tOWQ48hgKl7S0VKo/3EkdqMSAjlByavi5r64pBXun9C9qyS0ukUUzVFg5zn
         RLSixMLo++fPZn03DPpyTcZ4fvJIm12aRKCX5bemj/kuqHulCfIjtS/xoSPV+vhnbJxC
         N41STY44KeFUKctf6LEPG25ze0CQaS7VgQgGIH8ER7vfssfevvgW1/Pe+VetLeYAMwyA
         ZwVLDFNkdcBJHHfSYdNxhwWbnuDLBVWtjTWCQQNwkO9XXNVi/svO+1+MC9jmDTRTW/NN
         YHFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 079/183] i40evf: ignore link up if not running
Date: Wed, 25 Apr 2018 12:34:59 +0200
Message-Id: <20180425103245.682181232@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714348891032288?=
X-GMAIL-MSGID: =?utf-8?q?1598714348891032288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Brady <alan.brady@intel.com>


[ Upstream commit e0346f9fcb6c636d2f870e6666de8781413f34ea ]

If we receive the link status message from PF with link up before queues
are actually enabled, it will trigger a TX hang.  This fixes the issue
by ignoring a link up message if the VF state is not yet in RUNNING
state.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c |   35 +++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -937,23 +937,34 @@ void i40evf_virtchnl_completion(struct i
 	if (v_opcode == VIRTCHNL_OP_EVENT) {
 		struct virtchnl_pf_event *vpe =
 			(struct virtchnl_pf_event *)msg;
+		bool link_up = vpe->event_data.link_event.link_status;
 		switch (vpe->event) {
 		case VIRTCHNL_EVENT_LINK_CHANGE:
 			adapter->link_speed =
 				vpe->event_data.link_event.link_speed;
-			if (adapter->link_up !=
-			    vpe->event_data.link_event.link_status) {
-				adapter->link_up =
-					vpe->event_data.link_event.link_status;
-				if (adapter->link_up) {
-					netif_tx_start_all_queues(netdev);
-					netif_carrier_on(netdev);
-				} else {
-					netif_tx_stop_all_queues(netdev);
-					netif_carrier_off(netdev);
-				}
-				i40evf_print_link_message(adapter);
+
+			/* we've already got the right link status, bail */
+			if (adapter->link_up == link_up)
+				break;
+
+			/* If we get link up message and start queues before
+			 * our queues are configured it will trigger a TX hang.
+			 * In that case, just ignore the link status message,
+			 * we'll get another one after we enable queues and
+			 * actually prepared to send traffic.
+			 */
+			if (link_up && adapter->state != __I40EVF_RUNNING)
+				break;
+
+			adapter->link_up = link_up;
+			if (link_up) {
+				netif_tx_start_all_queues(netdev);
+				netif_carrier_on(netdev);
+			} else {
+				netif_tx_stop_all_queues(netdev);
+				netif_carrier_off(netdev);
 			}
+			i40evf_print_link_message(adapter);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "PF reset warning received\n");
