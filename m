Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvPbJjtESw+g/bTQt7EG3/AP9YEdD9qt/xIGNA57HGvIBVykvWeaIBOwnd6jnoalsHlIMER
ARC-Seal: i=1; a=rsa-sha256; t=1519412250; cv=none;
        d=google.com; s=arc-20160816;
        b=cKcg2Z73hgVSll+j3MN/vaqSMLm5SXRsGofft3YSmvLIjLYDNwd/mTMJOr0rIEitmK
         EL9CPIsTWb6XILxl8dpnwAZu9jzPUwzUm33bk7tZNuqqIN8E5ID4BZaj2nz0uq1UdJ54
         QqCGjvxQddbyyv8pitDkGsUGGzecZO4DrkQ/Q9moDJgxOvwb5jAa+X78Yc1UqoEZMPLT
         pM+KSBXWy2pRzqR7sd3GEh0B878B78PLHavkQUWS37hnaHu04/58SXPbACiuid3CNDpL
         XFTc6K36k9RqaNpIJQsujR28wuHnzdEmNpiBxF4OHzdLE6gnEbk07XvZ+uQ1pGZ1QJlJ
         p1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wT4FN/T/HIpBLDbA2fdyeuqfHmNisFOy1hXGGDma1vU=;
        b=nliX0NOEabPaMFn16/YxT5QmAV1Q4cgpSYgy2pvoyeZYCyhG7JXReMlFFfCoUh9ng6
         8lfuMI/F8INrBd0C83FHjjKLBPxGUbWLNAaKbaiOqSngj1GxLFIAH6CJApmdya2I5aRq
         Q9TEwUZOwvSkbYF3bzHAVYO4PpMOhhASHfArhOL5bBE9VOTeM94rIkW13fJcFDjlAPaY
         K13KT2R8TNbNkHI8DZoAWPApJuYhxZWfHN2tstfol3taOaTkSasfX2Fnr3RNdkM6nXN6
         j70dIlrqzQ9XyJSLjQ7+XXR3IbpzEBuCo8ZzG02qCL32EbxrmHq7mbiz7y9bBzyTUWXR
         sXKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4fbcfcc0d2e6592bd641@syzkaller.appspotmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4.15 17/45] netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()
Date: Fri, 23 Feb 2018 19:28:56 +0100
Message-Id: <20180223170718.112995410@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218318818277887?=
X-GMAIL-MSGID: =?utf-8?q?1593219219665580237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit ba7cd5d95f25cc6005f687dabdb4e7a6063adda9 upstream.

xt_cgroup_info_v1->priv is an internal pointer only used for kernel,
we should not trust what user-space provides.

Reported-by: <syzbot+4fbcfcc0d2e6592bd641@syzkaller.appspotmail.com>
Fixes: c38c4597e4bf ("netfilter: implement xt_cgroup cgroup2 path match")
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_cgroup.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -52,6 +52,7 @@ static int cgroup_mt_check_v1(const stru
 		return -EINVAL;
 	}
 
+	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);
 		if (IS_ERR(cgrp)) {
