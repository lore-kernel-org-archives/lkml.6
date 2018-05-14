Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo/0sjmXCDgMTMhij7cZKKExBPtz8JnuAkqaQ0FrFnif7/GzjmhKpLwiSxatPtvhAdLI6IU
ARC-Seal: i=1; a=rsa-sha256; t=1526280816; cv=none;
        d=google.com; s=arc-20160816;
        b=bUjexma4LL5fbsvQvrn8uRmEpkCyVkkwOu+1pdSN6y6Mmsg2oxNR/hoIb+DUDxf1ck
         HZr0m1vzvqzPVfHGFl3d5sOs7BiryF3yTamICanHiUM/KBbO9Sr3hq24ntbVBSq6SjKe
         lug2TO5kuQY6ODh37BxQQOFKQVKBgE4Rm9JV0KewNl7L4eop/MPA7xpEtpo7nh3v86he
         P68kJk+m8uj4LXgrCeW6hG0cE6ogZGNeI8YZP1JerLZnX2Vz2izAGpS8/sNeuobesChh
         rAbfcseuDrLiIk6tpMUwPKCRodsrr2nGMkplS6QRE4KJs72In5yt+TTChm4Npp6XWl2/
         uJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CelZgWrkN4m/QrXHa6G6ik2M3jsJ4StriUDgqgwxj2E=;
        b=jM606shjtaF6wtMgG6zs7Lwjs+w29hPG0SqVd4CkicmUbYQVOBJ8625w6adimF4a5y
         ZvlG+1826dx/uQFlcTK2JPdGtbetDwGTKu9ThQgiBP6FoHGVgBBaEiju3rX997Bs8Epr
         yPAZIadYXlrrX+qz25jhI/95iTAgdqG0/G7UChXdHP/56FWxLfk4+Mse5CM5fr2dqg5U
         2VxHDCSfhgdQtHLKo811NkpG8ABcOK98L81aj2InBDOSTzWwpuZdEqMbaCD8jlGLNjhG
         07TA7P8jXeiG0C9LU41Mxe9/Q2RSlMTHkVB5oyJ7X312C950i/RQC4aZrYi7jymDJ7e7
         K5rA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZnUTkjgC;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZnUTkjgC;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Doug Ledford <dledford@redhat.com>,
	Raju Rangoju <rajur@chelsio.com>
Subject: [PATCH 4.9 02/36] IB/device: Convert ib-comp-wq to be CPU-bound
Date: Mon, 14 May 2018 08:48:36 +0200
Message-Id: <20180514064804.414776688@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421433897173910?=
X-GMAIL-MSGID: =?utf-8?q?1600421433897173910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit b7363e67b23e04c23c2a99437feefac7292a88bc upstream.

This workqueue is used by our storage target mode ULPs
via the new CQ API. Recent observations when working
with very high-end flash storage devices reveal that
UNBOUND workqueue threads can migrate between cpu cores
and even numa nodes (although some numa locality is accounted
for).

While this attribute can be useful in some workloads,
it does not fit in very nicely with the normal
run-to-completion model we usually use in our target-mode
ULPs and the block-mq irq<->cpu affinity facilities.

The whole block-mq concept is that the completion will
land on the same cpu where the submission was performed.
The fact that our submitter thread is migrating cpus
can break this locality.

We assume that as a target mode ULP, we will serve multiple
initiators/clients and we can spread the load enough without
having to use unbound kworkers.

Also, while we're at it, expose this workqueue via sysfs which
is harmless and can be useful for debug.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>--
Signed-off-by: Doug Ledford <dledford@redhat.com>
Cc: Raju  Rangoju <rajur@chelsio.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/device.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -999,8 +999,7 @@ static int __init ib_core_init(void)
 		return -ENOMEM;
 
 	ib_comp_wq = alloc_workqueue("ib-comp-wq",
-			WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
-			WQ_UNBOUND_MAX_ACTIVE);
+			WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
 	if (!ib_comp_wq) {
 		ret = -ENOMEM;
 		goto err;
