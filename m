Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeDKO1r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:27:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751972AbeDKO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:27:45 -0400
Date: Wed, 11 Apr 2018 07:27:37 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Howard McLauchlan <hmclauchlan@fb.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, kernel-team@fb.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] uprobe: add support for overlayfs
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180410231030.2720-1-hmclauchlan@fb.com>
 <20180410200059.731d87fe@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180410200059.731d87fe@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18041114-0008-0000-0000-000004E953E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041114-0009-0000-0000-00001E7D5791
Message-Id: <20180411142737.GA16559@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110135
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt <rostedt@goodmis.org> [2018-04-10 20:00:59]:

> On Tue, 10 Apr 2018 16:10:30 -0700
> Howard McLauchlan <hmclauchlan@fb.com> wrote:
> 
> > uprobes cannot successfully attach to binaries located in a directory
> > mounted with overlayfs.
> > 
> > To verify, create directories for mounting overlayfs
> > (upper,lower,work,merge), move some binary into merge/ and use readelf
> > to obtain some known instruction of the binary. I used /bin/true and the
> > entry instruction(0x13b0):
> > 
> > 	$ mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merge
> > 	$ cd /sys/kernel/debug/tracing
> > 	$ echo 'p:true_entry PATH_TO_MERGE/merge/true:0x13b0' > uprobe_events
> > 	$ echo 1 > events/uprobes/true_entry/enable
> > 
> > This returns 'bash: echo: write error: Input/output error' and dmesg
> > tells us 'event trace: Could not enable event true_entry'
> 
> I tried the above and verified that it is a problem and your patch
> solves it.
> 
> Thanks, I'll apply it and start my tests on it.
> 
> -- Steve
> 
> > 
> > This change makes create_trace_uprobe() look for the real inode of a
> > dentry. In the case of normal filesystems, this simplifies to just
> > returning the inode. In the case of overlayfs(and similar fs) we will
> > obtain the underlying dentry and corresponding inode, upon which uprobes
> > can successfully register.
> > 
> > Running the example above with the patch applied, we can see that the
> > uprobe is enabled and will output to trace as expected.
> > 


Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> > Reviewed-by: Josef Bacik <jbacik@fb.com>
> > Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
> > ---
> >  kernel/trace/trace_uprobe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 2014f4351ae0..17c65fa4136d 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -446,7 +446,7 @@ static int create_trace_uprobe(int argc, char **argv)
> >  	if (ret)
> >  		goto fail_address_parse;
> >  
> > -	inode = igrab(d_inode(path.dentry));
> > +	inode = igrab(d_real_inode(path.dentry));
> >  	path_put(&path);
> >  
> >  	if (!inode || !S_ISREG(inode->i_mode)) {
> 
