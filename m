Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E35C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9C92086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="STNZz9N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9C92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeK1HDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:03:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeK1HDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:03:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARK4Obk097519;
        Tue, 27 Nov 2018 20:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Tv8Yj5RSWnoOnRoxpKd2+JSOo3EZ7RNg13+xVFIk6Wc=;
 b=STNZz9N8JoWBlgTyE5Izj7x28/xFOWmnwEsq1++N+/BPzQvzOFDKl0SWodigUeG2WwST
 +GJmoq3k5BkklVevVKYdNyJxti1P7WZGScZrNVc9tjDpdiFYcEfhw3M7qld/JGSw1fva
 ip0E6GlW2xkm3FZ0x+OOl4bXtxdfjm9GEF1eURvtJ5VmcQbiyPi2eBPxj9b47GGaY6V+
 fwnfWPdxyy0cjaea0SfabufEfjW5GhoBeEJstGfwmQWS6dxCgasAIsgOM3TsUnNfcHf2
 qQQSPrIJjVLC82LZ8CzPqj4B9Zfu/jgIjejS4xGtuhIIHHUwA59LntoackTaUoqJapAQ uA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nxx2u6as1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 20:04:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wARK4IW5010370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 20:04:19 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wARK4IYc002847;
        Tue, 27 Nov 2018 20:04:18 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 12:04:17 -0800
Date:   Tue, 27 Nov 2018 23:04:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix an off by one in __next()
Message-ID: <20181127200408.GG3073@unbuntlaptop>
References: <20180620110758.crunhd5bfep7zuiz@kili.mountain>
 <20181127134412.6f2141d4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127134412.6f2141d4@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 01:44:12PM -0500, Steven Rostedt wrote:
> 
> Doing the sweep of my INBOX, I came across this patch (it was sent
> while I was in the Alps :-)
> 
> 
> On Wed, 20 Jun 2018 14:08:00 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > The > should be >= to prevent an off by one bug.
> 
> Well, not really.
> 
> > 
> > >From reviewing the code, it seems possible for  
> > stack_trace_max.nr_entries to be set to .max_entries and in that case we
> > would be reading one element beyond the end of the stack_dump_trace[]
> > array.  If it's not set to .max_entries then the bug doesn't affect
> > runtime.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> > index 4237eba4ef20..6e3edd745c68 100644
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -286,7 +286,7 @@ __next(struct seq_file *m, loff_t *pos)
> >  {
> >  	long n = *pos - 1;
> >  
> > -	if (n > stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
> > +	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
> 
> We have:
> 
> static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
> 	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
> 
>  And
> 
> struct stack_trace stack_trace_max = {
> 	.max_entries		= STACK_TRACE_ENTRIES - 1,
> 	.entries		= &stack_dump_trace[0],
> };
> 
> 
> And nr_entries is set as this, and we have after that this:
> 
> 	stack_trace_max.nr_entries = x;
> 	for (; x < i; x++)
> 		stack_dump_trace[x] = ULONG_MAX;
> 
> Where we set stack_dump_trace[nr_entries] to ULONG_MAX.
> 
> Thus, nr_entries will not go pass the size of stack_dump_trace.
> 
> That said, if n == nr_entries, the second part of that if will always
> be true. And this is a bit subtle, so I will apply the patch. But it is
> not an off by one bug ;-)

Ah, yes.  I follow that now.  Thanks for taking the time to review this
patch.

I am optimistic that eventually I will fix how Smatch handles loops so
it maybe will be able to figure out that "x <= STACK_TRACE_ENTRIES - 1"
but that's probably some time off.

regards,
dan carpenter

