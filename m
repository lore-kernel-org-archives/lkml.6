Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeCMUKN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:10:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932544AbeCMUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:10:10 -0400
Date: Tue, 13 Mar 2018 13:10:03 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: John Garry <john.garry@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: perf-core build fails on powerpc
References: <20180313191742.GA29120@us.ibm.com>
 <152d2ba4-fe57-beab-87d5-554a0fede9ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152d2ba4-fe57-beab-87d5-554a0fede9ae@huawei.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18031320-0016-0000-0000-00000863230F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008667; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002585; UDB=6.00510161; IPR=6.00781915;
 MB=3.00020012; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-13 20:10:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031320-0017-0000-0000-00003DD45551
Message-Id: <20180313201003.GB29120@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130225
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Garry [john.garry@huawei.com] wrote:
> On 13/03/2018 19:17, Sukadev Bhattiprolu wrote:
> > 
> > 
> > Building perf on Powerpc seems broken when using Arnaldo's perf/core branch
> > with HEAD as:
> > 
> >     1b442ed ("perf test: Fix exit code for record+probe_libc_inet_pton.sh")
> > 
> > It maybe related to this commit:
> > 
> > 	commit d596299
> > 	Author: John Garry <john.garry@huawei.com>
> > 	Date:   Thu Mar 8 18:58:29 2018 +0800
> > 
> > 	    perf vendor events: Add support for pmu events vendor subdirectory
> > 
> > Reverting this hunk from tools/perf/pmu-events/jevents.c, seems to fix the
> > problem for me.
> > 

Hi John,

I have an xfs file system which seems to have d_type == DT_UNKNOWN for all
entries in 'tools/perf/pmu-events/arch/power8'! readdir(3) says ->d_type
may not be supported by all file systems.

Not relying on ->d_type seems to fix it:

@@ -873,26 +879,26 @@ static int is_leaf_dir(const char *fpath)
                return 0;
 
        while ((dir = readdir(d)) != NULL) {
-               if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
-                       res = 0;
-                       break;
-               } else if (dir->d_type == DT_UNKNOWN) {
-                       char path[PATH_MAX];
-                       struct stat st;
+               char path[PATH_MAX];
+               struct stat st;
 
-                       sprintf(path, "%s/%s", fpath, dir->d_name);
-                       if (stat(path, &st))
-                               break;
+               if (strcmp(dir->d_name, ".") == 0 ||
+                               strcmp(dir->d_name, "..") == 0)
+                       continue;
 
-                       if (S_ISDIR(st.st_mode)) {
-                               res = 0;
-                               break;
-                       }
+               sprintf(path, "%s/%s", fpath, dir->d_name);
+               if (stat(path, &st))
+                       break;
+
+               if (S_ISDIR(st.st_mode)) {
+                       res = 0;
+                       break;
