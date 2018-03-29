Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49GtXy+bppRLNGzKtWXltGUQkWcckoBKn70xNvrABGuU8I/wRaUXRZUtSvbCH9eBlCxhpUV
ARC-Seal: i=1; a=rsa-sha256; t=1522346689; cv=none;
        d=google.com; s=arc-20160816;
        b=XXa7PkLRoQ0kkOX15IOAZZ+Knd1BT6h0ff0Dsc938giLISO4AqY3UhLuZgAlL3kuLK
         m93uu9EaWTxm9iRob4rqXr3Ys2Uk4vMCT9GTw/S22MCP7xa+DTxnLnPnrklAPM5p1Mg0
         Mu/Pv7L1rC870vbaOMZMq0GQq18AACx4KZmujjAh5MALbnv/0XsUc2pgnH/Q9iMbGn4s
         BfL8ird/gvMOQNVhwcjCkIeHUqXBMndg932GP15lrpRMwY2c1m28NeOi3i2cS0CO+Nh9
         t7yt6FNKd8emz/+BND7jMHQYoFHXWIomBXMouHFyqf9OQ7XNXwaKxzN2KkyJ2sVUvRtw
         /DiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=doGo5vMUgxue4GVBoYpvj5ycOL1HIz5xdmZ1GDtMKNo=;
        b=Nk9d4f5lwmo/H+6Y0BqYSJyd9TTF7TTfuCzpyQgf1dDPelm/zrEGoz4S+KTyA7jFrA
         RMYSuj2NgrbnjJ+RoXW5h0bPYOF+Nbv3p6aTc7UOE544rfBG5ulILpC5dlolLlF3X6yV
         88LLyZUma6hZ9+NhhG/10SKtAo/odQVig+7UOidLqYWaGWDYwrYdx63f+3DF2/yzRiP/
         mAYANgE0ERbg5Xwr5HSheEDip0bNNgTOMvoP3HjiEqNsr70UOgm+MJHb5BP0Us6555Q2
         dYUnc/bRFosgCCbcuCTt3+RvF4q65KFuh+qU8zBkaamZw9jxWSV9HDyRaaZ0MZ3kLe7v
         WrQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/43] devlink: Remove redundant free on error path
Date: Thu, 29 Mar 2018 20:00:01 +0200
Message-Id: <20180329175730.767470403@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296060251224081?=
X-GMAIL-MSGID: =?utf-8?q?1596296202726060105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arkadi Sharshevsky <arkadis@mellanox.com>


[ Upstream commit 7fe4d6dcbcb43fe0282d4213fc52be178bb30e91 ]

The current code performs unneeded free. Remove the redundant skb freeing
during the error path.

Fixes: 1555d204e743 ("devlink: Support for pipeline debug (dpipe)")
Signed-off-by: Arkadi Sharshevsky <arkadis@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/devlink.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -1776,7 +1776,7 @@ send_done:
 	if (!nlh) {
 		err = devlink_dpipe_send_and_alloc_skb(&skb, info);
 		if (err)
-			goto err_skb_send_alloc;
+			return err;
 		goto send_done;
 	}
 
@@ -1785,7 +1785,6 @@ send_done:
 nla_put_failure:
 	err = -EMSGSIZE;
 err_table_put:
-err_skb_send_alloc:
 	genlmsg_cancel(skb, hdr);
 	nlmsg_free(skb);
 	return err;
@@ -2051,7 +2050,7 @@ static int devlink_dpipe_entries_fill(st
 					     table->counters_enabled,
 					     &dump_ctx);
 	if (err)
-		goto err_entries_dump;
+		return err;
 
 send_done:
 	nlh = nlmsg_put(dump_ctx.skb, info->snd_portid, info->snd_seq,
@@ -2059,16 +2058,10 @@ send_done:
 	if (!nlh) {
 		err = devlink_dpipe_send_and_alloc_skb(&dump_ctx.skb, info);
 		if (err)
-			goto err_skb_send_alloc;
+			return err;
 		goto send_done;
 	}
 	return genlmsg_reply(dump_ctx.skb, info);
-
-err_entries_dump:
-err_skb_send_alloc:
-	genlmsg_cancel(dump_ctx.skb, dump_ctx.hdr);
-	nlmsg_free(dump_ctx.skb);
-	return err;
 }
 
 static int devlink_nl_cmd_dpipe_entries_get(struct sk_buff *skb,
@@ -2207,7 +2200,7 @@ send_done:
 	if (!nlh) {
 		err = devlink_dpipe_send_and_alloc_skb(&skb, info);
 		if (err)
-			goto err_skb_send_alloc;
+			return err;
 		goto send_done;
 	}
 	return genlmsg_reply(skb, info);
@@ -2215,7 +2208,6 @@ send_done:
 nla_put_failure:
 	err = -EMSGSIZE;
 err_table_put:
-err_skb_send_alloc:
 	genlmsg_cancel(skb, hdr);
 	nlmsg_free(skb);
 	return err;
