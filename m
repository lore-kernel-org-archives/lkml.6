Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvRCUFq3/QUnQM2bdUH82Cg+rA7/RDtLFmEfQzyK6OB/bR4Ui+gs6EVmlCHeF6Y+f4zgQyJ
ARC-Seal: i=1; a=rsa-sha256; t=1521483288; cv=none;
        d=google.com; s=arc-20160816;
        b=P3NGIeATl7cZetiqltp3QwxjnG873M2VNqDBcVQ1crJ4gEZwqtiCqZwFY+6nsX7TpF
         ZfPJtpA24Tt9EQbFJ+e9SuCQerFyuIEeOEoFkQ66464LruYxTnAbjOVD/er9DvJLhfBV
         ggNRUP4E92ikyYRGQkLZB6hH5P/Djoapssrdu0pBn84uO0JXaYd5TPXjBBe1cyvx8sTJ
         knynTp4+LfaNzwTMtxtEh6VztsD6JgGYSfJMEtFQzMAOJl+MCJ8HDIcn+8lgaYUI3kVL
         ahntTVB4Buu2WWhOsFMDjsH87UxQRTzvHYvm/tzY12nBMI8CVIT55ajcwvWeUdENBrtA
         T/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3QxlR4l+fs8jWBAq6Mz+tvfTpmV93wv2pkT0l2gnoJE=;
        b=sYpQ1AjIHfRP7NOqpdiwAmuIFUYmIe17laJcE6PZYR/VZfTDHQoM/Bu8YrVzBuFyPj
         uRHcdcucCi+yjwyv/XO7pdUmXdhKmTAtl28iGqsAgpH1vNbZyCKVdSa6IuxKaf111CGh
         OA7YK0q2yebdfwky6l7OvK877S/a59G+J+Jko8Fwr3Jtawp8fK/c0rYUPvUnBlwPnWjh
         ZQFu8z1rnVfSbeql2P3QJdMUimhzEd/IcHeZhRFQlfSAoY12B932vcBiCKT+KbV+B1W0
         JFQfoBMeR2TsIj7+WYw2+N4j5HCWkPXP4Sj3xia6Aq3/UneMk6OP/i+x19WqfAvuDA9m
         mRYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	NeilBrown <neilb@suse.com>,
	Shaohua Li <shli@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 067/134] md/raid6: Fix anomily when recovering a single device in RAID6.
Date: Mon, 19 Mar 2018 19:05:50 +0100
Message-Id: <20180319171858.945193883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390860083366707?=
X-GMAIL-MSGID: =?utf-8?q?1595390860083366707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>


[ Upstream commit 7471fb77ce4dc4cb81291189947fcdf621a97987 ]

When recoverying a single missing/failed device in a RAID6,
those stripes where the Q block is on the missing device are
handled a bit differently.  In these cases it is easy to
check that the P block is correct, so we do.  This results
in the P block be destroy.  Consequently the P block needs
to be read a second time in order to compute Q.  This causes
lots of seeks and hurts performance.

It shouldn't be necessary to re-read P as it can be computed
from the DATA.  But we only compute blocks on missing
devices, since c337869d9501 ("md: do not compute parity
unless it is on a failed drive").

So relax the change made in that commit to allow computing
of the P block in a RAID6 which it is the only missing that
block.

This makes RAID6 recovery run much faster as the disk just
"before" the recovering device is no longer seeking
back-and-forth.

Reported-by-tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3372,9 +3372,20 @@ static int fetch_block(struct stripe_hea
 		BUG_ON(test_bit(R5_Wantcompute, &dev->flags));
 		BUG_ON(test_bit(R5_Wantread, &dev->flags));
 		BUG_ON(sh->batch_head);
+
+		/*
+		 * In the raid6 case if the only non-uptodate disk is P
+		 * then we already trusted P to compute the other failed
+		 * drives. It is safe to compute rather than re-read P.
+		 * In other cases we only compute blocks from failed
+		 * devices, otherwise check/repair might fail to detect
+		 * a real inconsistency.
+		 */
+
 		if ((s->uptodate == disks - 1) &&
+		    ((sh->qd_idx >= 0 && sh->pd_idx == disk_idx) ||
 		    (s->failed && (disk_idx == s->failed_num[0] ||
-				   disk_idx == s->failed_num[1]))) {
+				   disk_idx == s->failed_num[1])))) {
 			/* have disk failed, and we're requested to fetch it;
 			 * do compute it
 			 */
