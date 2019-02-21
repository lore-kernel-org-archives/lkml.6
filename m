Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C772148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBUIaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:30:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:24569 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:30:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 00:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,394,1544515200"; 
   d="scan'208";a="135994663"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2019 00:30:33 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [driver core] 570d020012: will-it-scale.per_thread_ops -12.2% regression
References: <20190218075442.GI29177@shao2-debian>
        <20190219005945.GA16734@richard> <20190219121904.GA24103@kroah.com>
        <20190221031049.GE28258@shao2-debian>
        <20190221071023.GA28637@kroah.com>
        <8736oh1uf5.fsf@yhuang-dev.intel.com>
        <20190221073510.GA17369@kroah.com>
Date:   Thu, 21 Feb 2019 16:30:32 +0800
In-Reply-To: <20190221073510.GA17369@kroah.com> (Greg Kroah-Hartman's message
        of "Thu, 21 Feb 2019 08:35:10 +0100")
Message-ID: <87va1dzgpj.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Feb 21, 2019 at 03:18:22PM +0800, Huang, Ying wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Thu, Feb 21, 2019 at 11:10:49AM +0800, kernel test robot wrote:
>> >> On Tue, Feb 19, 2019 at 01:19:04PM +0100, Greg Kroah-Hartman wrote:
>> >> > On Tue, Feb 19, 2019 at 08:59:45AM +0800, Wei Yang wrote:
>> >> > > On Mon, Feb 18, 2019 at 03:54:42PM +0800, kernel test robot wrote:
>> >> > > >Greeting,
>> >> > > >
>> >> > > >FYI, we noticed a -12.2% regression of will-it-scale.per_thread_ops due to commit:
>> >> > > >
>> >> > > >
>> >> > > >commit: 570d0200123fb4f809aa2f6226e93a458d664d70 ("driver core: move device->knode_class to device_private")
>> >> > > >https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>> >> > > >
>> >> > > 
>> >> > > This is interesting.
>> >> > > 
>> >> > > I didn't expect the move of this field will impact the performance.
>> >> > > 
>> >> > > The reason is struct device is a hotter memory than device->device_private?
>> >> > > 
>> >> > > >in testcase: will-it-scale
>> >> > > >on test machine: 288 threads Knights Mill with 80G memory
>> >> > > >with following parameters:
>> >> > > >
>> >> > > >	nr_task: 100%
>> >> > > >	mode: thread
>> >> > > >	test: unlink2
>> >> > > >	cpufreq_governor: performance
>> >> > > >
>> >> > > >test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
>> >> > > >test-url: https://github.com/antonblanchard/will-it-scale
>> >> > > >
>> >> > > >In addition to that, the commit also has significant impact on the following tests:
>> >> > > >
>> >> > > >+------------------+---------------------------------------------------------------+
>> >> > > >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -29.9% regression |
>> >> > > >| test machine     | 288 threads Knights Mill with 80G memory                      |
>> >> > > >| test parameters  | cpufreq_governor=performance                                  |
>> >> > > >|                  | mode=thread                                                   |
>> >> > > >|                  | nr_task=100%                                                  |
>> >> > > >|                  | test=signal1                                                  |
>> >> > 
>> >> > Ok, I'm going to blame your testing system, or something here, and not
>> >> > the above patch.
>> >> > 
>> >> > All this test does is call raise(3).  That does not touch the driver
>> >> > core at all.
>> >> > 
>> >> > > >+------------------+---------------------------------------------------------------+
>> >> > > >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -16.5% regression |
>> >> > > >| test machine     | 288 threads Knights Mill with 80G memory                      |
>> >> > > >| test parameters  | cpufreq_governor=performance                                  |
>> >> > > >|                  | mode=thread                                                   |
>> >> > > >|                  | nr_task=100%                                                  |
>> >> > > >|                  | test=open1                                                    |
>> >> > > >+------------------+---------------------------------------------------------------+
>> >> > 
>> >> > Same here, open1 just calls open/close a lot.  No driver core
>> >> > interaction at all there either.
>> >> > 
>> >> > So are you _sure_ this is the offending patch?
>> >> 
>> >> Hi Greg,
>> >> 
>> >> We did an experiment, recovered the layout of struct device. and we
>> >> found the regression is gone. I guess the regession is not from the
>> >> patch but related to the struct layout.
>> >> 
>> >> 
>> >> tests: 1
>> >> testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-unlink2/lkp-knm01
>> >> 
>> >> 570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>> >> ----------------  --------------------------  
>> >>          %stddev      change         %stddev
>> >>              \          |                \  
>> >>     237096              14%     270789        will-it-scale.workload
>> >>        823              14%        939        will-it-scale.per_thread_ops
>> >> 
>> >> 
>> >> tests: 1
>> >> testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-signal1/lkp-knm01
>> >> 
>> >> 570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>> >> ----------------  --------------------------  
>> >>          %stddev      change         %stddev
>> >>              \          |                \  
>> >>      93.51   3%        48%     138.53   3%  will-it-scale.time.user_time
>> >>        186              40%        261        will-it-scale.per_thread_ops
>> >>      53909              40%      75507        will-it-scale.workload
>> >> 
>> >> 
>> >> tests: 1
>> >> testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-open1/lkp-knm01
>> >> 
>> >> 570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>> >> ----------------  --------------------------  
>> >>          %stddev      change         %stddev
>> >>              \          |                \  
>> >>     447722              22%     546258  10%  will-it-scale.time.involuntary_context_switches
>> >>     226995              19%     269751        will-it-scale.workload
>> >>        787              19%        936        will-it-scale.per_thread_ops
>> >> 
>> >> 
>> >> 
>> >> commit a36dc70b810afe9183de2ea18faa4c0939c139ac
>> >> Author: 0day robot <lkp@intel.com>
>> >> Date:   Wed Feb 20 14:21:19 2019 +0800
>> >> 
>> >>     backfile klist_node in struct device for debugging
>> >>     
>> >>     Signed-off-by: 0day robot <lkp@intel.com>
>> >> 
>> >> diff --git a/include/linux/device.h b/include/linux/device.h
>> >> index d0e452fd0bff2..31666cb72b3ba 100644
>> >> --- a/include/linux/device.h
>> >> +++ b/include/linux/device.h
>> >> @@ -1035,6 +1035,7 @@ struct device {
>> >>  	spinlock_t		devres_lock;
>> >>  	struct list_head	devres_head;
>> >>  
>> >> +	struct klist_node       knode_class_test_by_rongc;
>> >>  	struct class		*class;
>> >>  	const struct attribute_group **groups;	/* optional groups */
>> >
>> > While this is fun to worry about alignment and structure size of 'struct
>> > device' I find it odd given that the syscalls and userspace load of
>> > those test programs have nothing to do with 'struct device' at all.
>> >
>> > So I can work on fixing up the alignment of struct device, as that's a
>> > nice thing to do for systems with 30k of these in memory, but that
>> > shouldn't affect a workload of a constant string of signal calls.
>> 
>> Hi, Greg,
>> 
>> I don't think this is an issues of struct device.  As you said, struct
>> device isn't access much during test.  Struct device may share slab page
>> with some other data structures (signal related, or fd related (as in
>> some other test cases)), so that the alignment of these data structures
>> are affected, so caused the performance regression.
>
> But allocation of a structure should always be "properly" aligned, no
> matter what something else did in the system as that is what kmalloc
> ensures.  If not, then we have problems in our memory allocator :)
>
> So something is odd here, but I don't think that is it...

If all these data structure are allocated with kmalloc() instead of
kmem_cache_alloc(), then my guessing above seems incorrect ...

Best Regards,
Huang, Ying
