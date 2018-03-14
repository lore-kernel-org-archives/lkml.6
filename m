Return-Path: <dichtel@6wind.com>
X-Google-Smtp-Source: AG47ELsV2kQ8QHFs58dIsubphVxOcAtUMdXftlLsFAIWv12XFLCd4zPq7srIwdtX8tB1L2yhQwgr
ARC-Seal: i=1; a=rsa-sha256; t=1521058269; cv=none;
        d=google.com; s=arc-20160816;
        b=s3Ixkx6VzqgIX7Lh2U+/0CHgG+cUbvsToIMMWEM5OtXFBQhJax5uqGbXJULP6ZoCx7
         M8xyeBRtO+q6aFzfcRakU2RZ5nzSd41lb1+SQ56HVwA4oanLhd4wC+GRDG2Iecilhi9u
         dGCxUmGRV47ATjRSpLP27rzYo+uKqTk0ipI4ixEEb6K/GiNxQ+DPn5Wdg+WFap366fyN
         CwrNCqXq17tB9LA5lrpXOwTRnzo/fhRP7FtWDRTcfjfKE6laxlKM7JQZx5YtVbTE0HYG
         rvDnmtANb0SQDI4vWekmqIQhPskJOr/6OsxrG3MFohrMmyD+hJWCHtyBh0FQZk2MPW92
         zNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dZgWyRb0+1CnBqDHGfEC6D2PAv3yJ83XqNzReYEnOy0=;
        b=Cw5mP3AsXJJetV+TKy8sH5SF43YTDjHUAl9EAui2lNWu7K+aO9y6sbb475xBUPdmDB
         x5aqRQlttBW4X8ROLdnBQxkjfK2qjj2gGGtcwTlBTbToSinltPPX2Vp32vPc3A2HCEss
         LQtvvPrgh09AGM1SXAvGnQCQuaLov+nJCB9SWVofoeOvuNDC5cabaxdagtWjb+G5CIca
         +dDbUwM3GazTrF6x9LeedIWpiaHmscS4AQ5oNpXoTkXHS4FuicLNqdkiPA3rsUF97xK7
         C0h3Dh83CunXGPqgj+e8FpIC49Jk90KS8a1GzHgj2FlNmYwFDd7gPK1Zn/bpv/adeeNY
         Bdwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 62.23.145.76 is neither permitted nor denied by best guess record for domain of dichtel@6wind.com) smtp.mailfrom=dichtel@6wind.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 62.23.145.76 is neither permitted nor denied by best guess record for domain of dichtel@6wind.com) smtp.mailfrom=dichtel@6wind.com
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: ben.hutchings@codethink.co.uk
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	johannes.berg@intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net] netlink: avoid a double skb free in genlmsg_mcast()
Date: Wed, 14 Mar 2018 21:10:23 +0100
Message-Id: <20180314201023.12407-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <1520899459.23626.87.camel@codethink.co.uk>
References: <1520899459.23626.87.camel@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594945195144415046?=
X-GMAIL-MSGID: =?utf-8?q?1594945195144415046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

nlmsg_multicast() consumes always the skb, thus the original skb must be
freed only when this function is called with a clone.

Fixes: cb9f7a9a5c96 ("netlink: ensure to loop over all netns in genlmsg_multicast_allns()")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/netlink/genetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 6f02499ef007..b9ce82c9440f 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1106,7 +1106,7 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
-		goto error;
+		return err;
 	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
-- 
2.15.1
