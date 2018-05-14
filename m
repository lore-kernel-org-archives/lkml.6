Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpUevxADjA/Kiv7z422+qgDhX+7ljV1sLyJccKYtmnNp/i8JFd56HaGcuqQJz9jg9QukO+b
ARC-Seal: i=1; a=rsa-sha256; t=1526280938; cv=none;
        d=google.com; s=arc-20160816;
        b=hK8m7VNRNyGcfn5CdS2F8pm/CndZYRToyk08FnBLsp1+dB5vS4FMxJnIrXx1kSzvCb
         B9jXNsXZPcobKcFlR4yTw0r29UG9ptfZMBIXrMuaocdB+z1+yGELyW7dAWnaISaNdcIV
         Y/742BfuYIGFGEP8MQdon/+QhqeCxTWNgv3K0D/bYmXPy1ed7iJ4DlHuUDdFnclLAuOB
         8RUWRYKRkzHkcf2kqjVfkWVivg2ufEf86pQqiMA+rFuM6ze67BgaXKW3Gs1GAHcgeIaC
         HcXuFFcfcx949oB0E3dyHxk9vv+4QQ7yF9zqFh4tMpiaaoJbRh9nuyxkPnUVm/Ysbskk
         Qvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9laIAd25bap/JMjyVgEkSzVV0y5nYL/C8QeFQZJtr+E=;
        b=e3QTvPwx9T0W+AXQd/ljSNX8ejbP0Kouh2uOeV4pQ60FfelPr5bFAVU3MdCCn/JxWI
         TwR3lR+wd+dQmoDSz8Tje+DOF8/FLNfe+nd4bLHdo1dD4ySXkllCdO7uoBse+W2m6oII
         ZWCIxcyEfBnWsguJmTO8w5vWiHEOnbJWcUDQJJSwdhtZa4BtylXHE+px/K5/8ws1Ziet
         q/CGiljXlL87R66SW3AmdVj3Dk+5/GvPZXBnHy07K+tb1PjrW4cGFyCaJ0KGr5Kg98wB
         q9Qz4kMydfqrPtpPmSowqJKybjL4hG1jeA9yRIcOMxzx0pUWXpO95GIXNa9Nw3iFbRrv
         15HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D+XnXqNz;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D+XnXqNz;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 02/62] netfilter: ebtables: dont attempt to allocate 0-sized compat array
Date: Mon, 14 May 2018 08:48:18 +0200
Message-Id: <20180514064816.597030977@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421561105028359?=
X-GMAIL-MSGID: =?utf-8?q?1600421561105028359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 3f1e53abff84cf40b1adb3455d480dd295bf42e8 upstream.

Dmitry reports 32bit ebtables on 64bit kernel got broken by
a recent change that returns -EINVAL when ruleset has no entries.

ebtables however only counts user-defined chains, so for the
initial table nentries will be 0.

Don't try to allocate the compat array in this case, as no user
defined rules exist no rule will need 64bit translation.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: 7d7d7e02111e9 ("netfilter: compat: reject huge allocation requests")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1819,13 +1819,14 @@ static int compat_table_info(const struc
 {
 	unsigned int size = info->entries_size;
 	const void *entries = info->entries;
-	int ret;
 
 	newinfo->entries_size = size;
-
-	ret = xt_compat_init_offsets(NFPROTO_BRIDGE, info->nentries);
-	if (ret)
-		return ret;
+	if (info->nentries) {
+		int ret = xt_compat_init_offsets(NFPROTO_BRIDGE,
+						 info->nentries);
+		if (ret)
+			return ret;
+	}
 
 	return EBT_ENTRY_ITERATE(entries, size, compat_calc_entry, info,
 							entries, newinfo);
