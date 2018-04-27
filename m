Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpqz1gESJWQ20CFnKYJsr3rWOguR5SlbbiYbWNinhUgtjqhAdKgWxiUW5EmDOMHni5UgPQF
ARC-Seal: i=1; a=rsa-sha256; t=1524838020; cv=none;
        d=google.com; s=arc-20160816;
        b=irD/mLM6ojTE7+zM3GS8w05DzXeCWn6bjK7/87oc8+ViV9Cl91qNTLc9n5Bgj6vlw+
         /00pr+wrJdJlFAhLHqOO3w0/0/dj7sx8UADAkD9yM8r9cQkn8Tkfp83R8l7szCCpUo1D
         8YV7b/A2Z0Hj1SAGR7WJXTeAadz585LkTNq/DtCXF/sOo3f6jSrIN7FiUOsizEup2LjO
         F5dQ0LiqHG3ZbnplPfCcRbIr78QsdNG2zUCpVg9bj7L4gGKaCh19PIExlrD0Xg2f734l
         HQdAURu5lKCVG0T4A4epJ5nYnyEKjW1D7opqItMf/G+CPziosxG5GNa2uxnhwdoqsMXd
         vKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=c5rmrRg+VfyFyk9iXdIjA/nYTkx0w6JuwVtvZgF9OHI=;
        b=p6wO10o2KP+9Clzk1BEv1G9iWXiP5dsOvv6s046puGVtC6UWJgIOlxjgZPFk1jUrUB
         9IhAH9P5RdsUUJibNNIYN0nktyAtR4YqM9hmOJkPehYy2TGKHGfSR7TmscVa9XgIWOQv
         92rCq7iir38xKWq3SwCSP784OXl1xTyxIh2l8y8dYd8aArXbVwdKxjXjWJ0Oox2UEICU
         em8e/CfKQmjDT7ZPdcBvOxVXvklq9gUxvfBLlxhrd9gpSW40teHIH7e5Kt7crBhzs3px
         Mn4s0ViEAZr/NAxhSu+f3Jf7822kKkR+TzC9ksyCQqORh6DSWyRF/2WKCYAwiNbB+cdO
         EnRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B59A21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Pawe=C5=82=20Jab=C5=82o=C5=84ski?= <pawel.jablonski@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH 4.14 03/80] i40e: Fix attach VF to VM issue
Date: Fri, 27 Apr 2018 15:57:56 +0200
Message-Id: <20180427135733.087882980@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908551731107352?=
X-GMAIL-MSGID: =?utf-8?q?1598908551731107352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paweł Jabłoński <pawel.jablonski@intel.com>

commit 028daf80117376b22909becd9720daaefdfceff4 upstream.

Fix for "Resource temporarily unavailable" problem when virsh is
trying to attach a device to VM. When the VF driver is loaded on
host and virsh is trying to attach it to the VM and set a MAC
address, it ends with a race condition between i40e_reset_vf and
i40e_ndo_set_vf_mac functions. The bug is fixed by adding polling
in i40e_ndo_set_vf_mac function For when the VF is in Reset mode.

Signed-off-by: Paweł Jabłoński <pawel.jablonski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2781,6 +2781,7 @@ int i40e_ndo_set_vf_mac(struct net_devic
 	int ret = 0;
 	struct hlist_node *h;
 	int bkt;
+	u8 i;
 
 	/* validate the request */
 	if (vf_id >= pf->num_alloc_vfs) {
@@ -2792,6 +2793,16 @@ int i40e_ndo_set_vf_mac(struct net_devic
 
 	vf = &(pf->vf[vf_id]);
 	vsi = pf->vsi[vf->lan_vsi_idx];
+
+	/* When the VF is resetting wait until it is done.
+	 * It can take up to 200 milliseconds,
+	 * but wait for up to 300 milliseconds to be safe.
+	 */
+	for (i = 0; i < 15; i++) {
+		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
+			break;
+		msleep(20);
+	}
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
 		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
 			vf_id);
