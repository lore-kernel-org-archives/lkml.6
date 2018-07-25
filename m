Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57970C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5A620833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5A620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbeGYTYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:24:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729524AbeGYTYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:24:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PI4Xp7016271
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:11:21 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kevj23utm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:11:20 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jallen@linux.ibm.com>;
        Wed, 25 Jul 2018 12:11:20 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 12:11:17 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PIBGmC3473734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 11:11:16 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B2E16E059;
        Wed, 25 Jul 2018 12:11:16 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 046886E04C;
        Wed, 25 Jul 2018 12:11:15 -0600 (MDT)
Received: from localhost (unknown [9.41.92.142])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jul 2018 12:11:15 -0600 (MDT)
Date:   Wed, 25 Jul 2018 13:11:15 -0500
From:   John Allen <jallen@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     jallen@linux.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
        n-horiguchi@ah.jp.nec.com, mgorman@suse.de, mhocko@suse.cz
Subject: Infinite looping observed in __offline_pages
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180622-63-e52393
X-TM-AS-GCONF: 00
x-cbid: 18072518-0004-0000-0000-0000146883EF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009426; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066026; UDB=6.00547653; IPR=6.00843885;
 MB=3.00022322; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 18:11:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072518-0005-0000-0000-00008836CB21
Message-Id: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=984 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Under heavy stress and constant memory hot add/remove, I have observed 
the following loop to occasionally loop infinitely:

mm/memory_hotplug.c:__offline_pages

repeat:
        /* start memory hot removal */
        ret = -EINTR;
        if (signal_pending(current))
                goto failed_removal;

        cond_resched();
        lru_add_drain_all();
        drain_all_pages(zone);

        pfn = scan_movable_pages(start_pfn, end_pfn);
        if (pfn) { /* We have movable pages */
                ret = do_migrate_range(pfn, end_pfn);
                goto repeat;
        }

What appears to be happening in this case is that do_migrate_range 
returns a failure code which is being ignored. The failure is stemming 
from migrate_pages returning "1" which I'm guessing is the result of us 
hitting the following case:

mm/migrate.c: migrate_pages

	default:
		/*
		 * Permanent failure (-EBUSY, -ENOSYS, etc.):
		 * unlike -EAGAIN case, the failed page is
		 * removed from migration page list and not
		 * retried in the next outer loop.
		 */
		nr_failed++;
		break;
	}

Does a failure in do_migrate_range indicate that the range is 
unmigratable and the loop in __offline_pages should terminate and goto 
failed_removal? Or should we allow a certain number of retrys before we
give up on migrating the range?

This issue was observed on a ppc64le lpar on a 4.18-rc6 kernel.

-John

