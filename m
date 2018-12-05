Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD80C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5B7214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5B7214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeLEKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:01:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728581AbeLEKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:01:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB59x2gc125432
        for <linux-kernel@vger.kernel.org>; Wed, 5 Dec 2018 05:01:55 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p6ag2er41-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 05:01:55 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 5 Dec 2018 10:01:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Dec 2018 10:01:46 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB5A1jai4194674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 10:01:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0960FAE045;
        Wed,  5 Dec 2018 10:01:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD2E7AE051;
        Wed,  5 Dec 2018 10:01:41 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  5 Dec 2018 10:01:41 +0000 (GMT)
Date:   Wed, 5 Dec 2018 15:31:41 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
        liu.song.a23@gmail.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v2] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20181204005803.787578e7@vmware.local.home>
 <20181205033423.26242-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181205033423.26242-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18120510-0008-0000-0000-0000029D245C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120510-0009-0000-0000-000022078688
Message-Id: <20181205100141.GA8473@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-12-05 09:04:23]:

> There could be a race between task exit and probe unregister:
> 
>   exit_mm()
>   mmput()
>   __mmput()                     uprobe_unregister()
>   uprobe_clear_state()          put_uprobe()
>   delayed_uprobe_remove()       delayed_uprobe_remove()
> 
> put_uprobe() is calling delayed_uprobe_remove() without taking
> delayed_uprobe_lock and thus the race sometimes results in a
> kernel crash. Fix this by taking delayed_uprobe_lock before
> calling delayed_uprobe_remove() from put_uprobe().
> 
> Detailed crash log can be found at:
>   https://lkml.org/lkml/2018/11/1/1244
> 
> Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
> Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>  kernel/events/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 322e97bbb437..abbd8da9ac21 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
>  		 * gets called, we don't get a chance to remove uprobe from
>  		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
>  		 */
> +		mutex_lock(&delayed_uprobe_lock);
>  		delayed_uprobe_remove(uprobe, NULL);
> +		mutex_unlock(&delayed_uprobe_lock);
>  		kfree(uprobe);
>  	}
>  }
> -- 
> 2.19.2
> 

-- 
Thanks and Regards
Srikar Dronamraju

