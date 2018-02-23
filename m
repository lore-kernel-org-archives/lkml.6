Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225tnFhHLGJEr+GR5S7w8gajeL3TJWgwaxTKz2kOR76qa1cu8BCCVGDDh1XcGRN+tipWcBCD
ARC-Seal: i=1; a=rsa-sha256; t=1519412183; cv=none;
        d=google.com; s=arc-20160816;
        b=HJLT3812LkJ/EE2mLCnO5Lkm5V3XVPQgoAFd9Zqx5znB2VBuhjkePNUWxvtUfHztuB
         +xU599JS0Ao7SMkJDYry1I64q20upkBM25HTNxfV0M3EXxpPdIn0jOUGhZjO4dbozPdk
         OPyxsB/1Dc05PCwnAZbg9+wpp7NMt1OkbA4z94CDX9QocDQC8HetVgtSfbevDse9yTWB
         sECwuWXfAsIL5YxPSU7hhj9h0uVTZOIfsfHJCW9rvkDCgN8ZZboVG1E/M9axTl1k8fHO
         lAHiFe4jEuFJH/S8Xbl3/59Gv6fN6wTYkxj+ly6mAb//l/2oQJRn742TFPa06tA70oMs
         iYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I2Pj2Vfpcu+sncBPg1+/ANQjpCnjdznQfA+/TuP6jGE=;
        b=WfLC0F8CwN+94NbpJ0uGf0GcOzZUsIGBqfwghKdfeqfmahkD/QYPtBbYgrDrF73fAk
         6VTgg3VZycJaiINUaoSFYklc0K+CVK6sKdoRj+aYQ2dvFTEYoXXyKTnqSnfnKubSmrP3
         ynJ7PjoOSQe5wbXChux6Q4wsO/hzGkSH5bIsD59HuGZCZ9Ybv9mL9LDzkFE9Owc4jjB3
         UQCwLBpu2VkQx9+EH3MtcyIWS1vgP+8XEmrjioZ041wSmlt1IM3QD8fsXlCTeDpzT+uI
         TnuQVuIwiExU32gLGpiUQaRx6I+8xoU/k4SumqRDK5YY0vYioYhqIceh2pZva1yc6QYl
         DYwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 116/159] net: qualcomm: rmnet: Fix leak on transmit failure
Date: Fri, 23 Feb 2018 19:27:04 +0100
Message-Id: <20180223170757.353074376@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219149353364003?=
X-GMAIL-MSGID: =?utf-8?q?1593219149353364003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>


[ Upstream commit c20a548792f15f8d8e38cd74356301c6db0d241f ]

If a skb in transmit path does not have sufficient headroom to add
the map header, the skb is not sent out and is never freed.

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -166,12 +166,12 @@ static int rmnet_map_egress_handler(stru
 
 	if (skb_headroom(skb) < required_headroom) {
 		if (pskb_expand_head(skb, required_headroom, 0, GFP_KERNEL))
-			return RMNET_MAP_CONSUMED;
+			goto fail;
 	}
 
 	map_header = rmnet_map_add_map_header(skb, additional_header_len, 0);
 	if (!map_header)
-		return RMNET_MAP_CONSUMED;
+		goto fail;
 
 	if (port->egress_data_format & RMNET_EGRESS_FORMAT_MUXING) {
 		if (ep->mux_id == 0xff)
@@ -183,6 +183,10 @@ static int rmnet_map_egress_handler(stru
 	skb->protocol = htons(ETH_P_MAP);
 
 	return RMNET_MAP_SUCCESS;
+
+fail:
+	kfree_skb(skb);
+	return RMNET_MAP_CONSUMED;
 }
 
 /* Ingress / Egress Entry Points */
