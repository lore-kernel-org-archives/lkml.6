Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Pjg38c8C8+lJ9cu+LK7C4LmtD1hZuaNUuA0CoSITZqcs/7EXqTMA/xV0oXKw+YydW8XrV
ARC-Seal: i=1; a=rsa-sha256; t=1523021444; cv=none;
        d=google.com; s=arc-20160816;
        b=ipTwk0QajthAu3EpCmq9P2iOOelUtkdpnZ5qjYrIA/wDX4xbLQqC2znhXo+Pvj0JcN
         HKYhiOUPknUpXWkIWvLHwRcgmkLN/L1E8jj2XpRdSS0zlkIYaOnQpC6zaQ3UFlsu0mHL
         vL75cU6bTE0q1JB6v6OcE0Rae6wYuJKqJM6EgWm9kOFVF3tOGygwXVAcsmG1UzxFucyH
         JiCpBnpWaEjSE3WqhcgxdU+WJ+tX1FqcQsdof7AaVDqOaNb3sQBBZNn5p/18P5iCZu6k
         qOG5z9uYyxpD5n4BPzgX3iGaHyxAUEgoe2v8wMVCTuL5f6OyhnTNXxyHasW7CKIRjjFT
         OGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YFg5p5pI6/j6L52zm8IV5rxtEyTOzlUelDGcMyfEy1Y=;
        b=Bjo1+RJJtxal/daZzF+IxunIXaBB+G9j2bbPJJLPrJco+NBO5FD5rnufw0ry1RmBLp
         vLof9985+GxHnFmGrmWALFO2Q/Qu1ytHpD9YjDwTylorXpM29+Wvt4UG+u7xo9k6fj4y
         7lH3qXzi2Qo1xfXXQpmxC5ZcycRRXBe6Et/n6aBxaQimZ4hwRoTzw4lBcRnIy2RMYYNT
         Y6eIWHN+spNVOw++vGmtBRru9kFAVCPTm2lq8ckdNt9y87RAdsTXE4Cfh//LTum2GPDE
         Ncp4czV53aYQpS0d7pwh31pRv8wTwEyqDYqCJ6Y589rqdVBullOkKTZ6yEqfdemx3qQ3
         3v+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.4 38/72] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
Date: Fri,  6 Apr 2018 15:23:39 +0200
Message-Id: <20180406084308.351558223@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003595252777127?=
X-GMAIL-MSGID: =?utf-8?q?1597003734471414547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

commit 19d7df69fdb2636856dc8919de72fc1bf8f79598 upstream.

We don't have a compat layer for xfrm, so userspace and kernel
structures have different sizes in this case. This results in
a broken configuration, so refuse to configure socket policies
when trying to insert from 32 bit userspace as we do it already
with policies inserted via netlink.

Reported-and-tested-by: syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[use is_compat_task() - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1845,6 +1845,11 @@ int xfrm_user_policy(struct sock *sk, in
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
+#ifdef CONFIG_COMPAT
+	if (is_compat_task())
+		return -EOPNOTSUPP;
+#endif
+
 	if (!optval && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
