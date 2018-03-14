Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeCNRnB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:43:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752096AbeCNRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:42:59 -0400
Date: Wed, 14 Mar 2018 10:42:51 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, wcohen@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf vendor events: fix processing for xfs
References: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18031417-0052-0000-0000-000002C9826E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003011; UDB=6.00510415; IPR=6.00782341;
 MB=3.00020034; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 17:42:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031417-0053-0000-0000-00005BFEB698
Message-Id: <20180314174251.GA28324@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Garry [john.garry@huawei.com] wrote:
> In the recently introduced support for vendor subdirectory,
> the checking for directory entries under xfs (or any other fs
> which does not support dirent.d_type) is missing the check
> for links for current and parent directory. This can result
> in a broken pmu_events.c being generated.

I run into the problem on a 4.15-based kernel/xfs but not on a
3.10-based kernel! Have not investigated, but this fix is good.
> 
> Fix this by adding the appropriate check in is_leaf_dir().
> 
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Tested-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Thanks John.

Sukadev
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 1c01844..db3a594 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -873,7 +873,10 @@ static int is_leaf_dir(const char *fpath)
>  		return 0;
> 
>  	while ((dir = readdir(d)) != NULL) {
> -		if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
> +		if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
> +			continue;
> +
> +		if (dir->d_type == DT_DIR) {
>  			res = 0;
>  			break;
>  		} else if (dir->d_type == DT_UNKNOWN) {
> -- 
> 1.9.1
