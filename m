Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq14IsgN0S2V5TQU1/kW90v/+ph6/bWFNGpq/Hz6rHYWsYjWy9DEzONIVONq1ba++JOMUYY
ARC-Seal: i=1; a=rsa-sha256; t=1526280833; cv=none;
        d=google.com; s=arc-20160816;
        b=I9YqZxhto9TUOH8inB1qCyOogFFpaVggNwsOE6vgZy3DlKX+veHj8oxjdKPXN6kNhu
         PbDXBskeC2KmnXlaX1FoXK3xBzPZkGN6Jfa+PKh9e/NpmvkmQYwZWBSKSE8z/8wBcvG4
         csZcFMiyy3Rm3TrOtO1u2l21CvTqgk/W7Ceu+R2Q1fNPEPk6dJ0whJ2T8YWUAE3z8hDm
         LKUt4CpA2toA83ZHGncIM+obGLZpRZPKgI3ZT2L2wIFpvozTLtgJLVKJ99utanrTtOxE
         1WEsyHOJlbxrEogO7idtkJG1pRIpJQpD75iHyQLhesJcoZZHYJmNRfpSnKXr44bQzde4
         r2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=71arw0/UHh5NaUkZmY/UgXvaONOT0/dna1c2zLTPMdY=;
        b=As2yeckQqVYfpM3iZDFrspEHEH3kAmF9uw8BD4u8NNd25cETjA3LNXzeOp8im0k834
         NNz6l3UnKgbBPkkmhZ7o4UXd2He8qWmZn0d1LnCwEzEcs36oP/CuKarqt419nsdXOdPd
         HZZt6Vox/6COJmIxQuoamGleAop7sz1ArSqDa+Jd+kCqNcCX1fa6b/Br3qPz70JpydMg
         cVPq+2Ng2b1nVj8IQEpDQ1FDAjDvNHjGNkciB4MZLVlze3mMEBCzfaaMFXjhlLEOtwGh
         A0a4RAjvX+EJh3lmQx4ytIZx5b5l3MrWagkSM0P3REX0/uwuoHHY4AbandrQ8Ib7AOWv
         QeSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kX+eJlnX;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kX+eJlnX;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 08/36] net: fix uninit-value in __hw_addr_add_ex()
Date: Mon, 14 May 2018 08:48:42 +0200
Message-Id: <20180514064804.970885561@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421247484712480?=
X-GMAIL-MSGID: =?utf-8?q?1600421451176929449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 77d36398d99f2565c0a8d43a86fd520a82e64bb8 upstream.

syzbot complained :

BUG: KMSAN: uninit-value in memcmp+0x119/0x180 lib/string.c:861
CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 memcmp+0x119/0x180 lib/string.c:861
 __hw_addr_add_ex net/core/dev_addr_lists.c:60 [inline]
 __dev_mc_add+0x1c2/0x8e0 net/core/dev_addr_lists.c:670
 dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
 igmp6_group_added+0x2db/0xa00 net/ipv6/mcast.c:662
 ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
 addrconf_join_solict net/ipv6/addrconf.c:2078 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:3828 [inline]
 addrconf_dad_work+0x427/0x2150 net/ipv6/addrconf.c:3954
 process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2113
 worker_thread+0x113c/0x24f0 kernel/workqueue.c:2247
 kthread+0x539/0x720 kernel/kthread.c:239

Fixes: f001fde5eadd ("net: introduce a list of device addresses dev_addr_list (v6)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/dev_addr_lists.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -57,8 +57,8 @@ static int __hw_addr_add_ex(struct netde
 		return -EINVAL;
 
 	list_for_each_entry(ha, &list->list, list) {
-		if (!memcmp(ha->addr, addr, addr_len) &&
-		    ha->type == addr_type) {
+		if (ha->type == addr_type &&
+		    !memcmp(ha->addr, addr, addr_len)) {
 			if (global) {
 				/* check if addr is already used as global */
 				if (ha->global_use)
