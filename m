Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4095CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3382084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfBUG3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:29:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:24590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfBUG3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:29:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 22:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,393,1544515200"; 
   d="scan'208";a="276681968"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2019 22:29:42 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [driver core] 570d020012: will-it-scale.per_thread_ops -12.2% regression
References: <20190218075442.GI29177@shao2-debian>
        <20190219005945.GA16734@richard> <20190219121904.GA24103@kroah.com>
        <20190221031049.GE28258@shao2-debian> <20190221034612.GA15147@richard>
        <87h8cx21gl.fsf@yhuang-dev.intel.com> <20190221060218.GA19466@richard>
Date:   Thu, 21 Feb 2019 14:29:42 +0800
In-Reply-To: <20190221060218.GA19466@richard> (Wei Yang's message of "Thu, 21
        Feb 2019 14:02:18 +0800")
Message-ID: <87d0nl1wo9.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richardw.yang@linux.intel.com> writes:

> On Thu, Feb 21, 2019 at 12:46:18PM +0800, Huang, Ying wrote:
>>Wei Yang <richardw.yang@linux.intel.com> writes:
>>
>>> On Thu, Feb 21, 2019 at 11:10:49AM +0800, kernel test robot wrote:
>>>>On Tue, Feb 19, 2019 at 01:19:04PM +0100, Greg Kroah-Hartman wrote:
>>>>> On Tue, Feb 19, 2019 at 08:59:45AM +0800, Wei Yang wrote:
>>>>> > On Mon, Feb 18, 2019 at 03:54:42PM +0800, kernel test robot wrote:
>>>>> > >Greeting,
>>>>> > >
>>>>> > >FYI, we noticed a -12.2% regression of will-it-scale.per_thread_ops due to commit:
>>>>> > >
>>>>> > >
>>>>> > >commit: 570d0200123fb4f809aa2f6226e93a458d664d70 ("driver core: move device->knode_class to device_private")
>>>>> > >https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>>> > >
>>>>> > 
>>>>> > This is interesting.
>>>>> > 
>>>>> > I didn't expect the move of this field will impact the performance.
>>>>> > 
>>>>> > The reason is struct device is a hotter memory than device->device_private?
>>>>> > 
>>>>> > >in testcase: will-it-scale
>>>>> > >on test machine: 288 threads Knights Mill with 80G memory
>>>>> > >with following parameters:
>>>>> > >
>>>>> > >	nr_task: 100%
>>>>> > >	mode: thread
>>>>> > >	test: unlink2
>>>>> > >	cpufreq_governor: performance
>>>>> > >
>>>>> > >test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
>>>>> > >test-url: https://github.com/antonblanchard/will-it-scale
>>>>> > >
>>>>> > >In addition to that, the commit also has significant impact on the following tests:
>>>>> > >
>>>>> > >+------------------+---------------------------------------------------------------+
>>>>> > >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -29.9% regression |
>>>>> > >| test machine     | 288 threads Knights Mill with 80G memory                      |
>>>>> > >| test parameters  | cpufreq_governor=performance                                  |
>>>>> > >|                  | mode=thread                                                   |
>>>>> > >|                  | nr_task=100%                                                  |
>>>>> > >|                  | test=signal1                                                  |
>>>>> 
>>>>> Ok, I'm going to blame your testing system, or something here, and not
>>>>> the above patch.
>>>>> 
>>>>> All this test does is call raise(3).  That does not touch the driver
>>>>> core at all.
>>>>> 
>>>>> > >+------------------+---------------------------------------------------------------+
>>>>> > >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -16.5% regression |
>>>>> > >| test machine     | 288 threads Knights Mill with 80G memory                      |
>>>>> > >| test parameters  | cpufreq_governor=performance                                  |
>>>>> > >|                  | mode=thread                                                   |
>>>>> > >|                  | nr_task=100%                                                  |
>>>>> > >|                  | test=open1                                                    |
>>>>> > >+------------------+---------------------------------------------------------------+
>>>>> 
>>>>> Same here, open1 just calls open/close a lot.  No driver core
>>>>> interaction at all there either.
>>>>> 
>>>>> So are you _sure_ this is the offending patch?
>>>>
>>>>Hi Greg,
>>>>
>>>>We did an experiment, recovered the layout of struct device. and we
>>>>found the regression is gone. I guess the regession is not from the
>>>>patch but related to the struct layout.
>>>>
>>>>
>>>>tests: 1
>>>>testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-unlink2/lkp-knm01
>>>>
>>>>570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>>>>----------------  --------------------------  
>>>>         %stddev      change         %stddev
>>>>             \          |                \  
>>>>    237096              14%     270789        will-it-scale.workload
>>>>       823              14%        939        will-it-scale.per_thread_ops
>>>>
>>>
>>> Do you have the comparison between a36dc70b810afe9183de2ea18f and the one
>>> before 570d020012?
>>>
>>>>
>>>>tests: 1
>>>>testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-signal1/lkp-knm01
>>>>
>>>>570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>>>>----------------  --------------------------  
>>>>         %stddev      change         %stddev
>>>>             \          |                \  
>>>>     93.51   3%        48%     138.53   3%  will-it-scale.time.user_time
>>>>       186              40%        261        will-it-scale.per_thread_ops
>>>>     53909              40%      75507        will-it-scale.workload
>>>>
>>>>
>>>>tests: 1
>>>>testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-open1/lkp-knm01
>>>>
>>>>570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>>>>----------------  --------------------------  
>>>>         %stddev      change         %stddev
>>>>             \          |                \  
>>>>    447722              22%     546258  10%  will-it-scale.time.involuntary_context_switches
>>>>    226995              19%     269751        will-it-scale.workload
>>>>       787              19%        936        will-it-scale.per_thread_ops
>>>>
>>>>
>>>>
>>>>commit a36dc70b810afe9183de2ea18faa4c0939c139ac
>>>>Author: 0day robot <lkp@intel.com>
>>>>Date:   Wed Feb 20 14:21:19 2019 +0800
>>>>
>>>>    backfile klist_node in struct device for debugging
>>>>    
>>>>    Signed-off-by: 0day robot <lkp@intel.com>
>>>>
>>>>diff --git a/include/linux/device.h b/include/linux/device.h
>>>>index d0e452fd0bff2..31666cb72b3ba 100644
>>>>--- a/include/linux/device.h
>>>>+++ b/include/linux/device.h
>>>>@@ -1035,6 +1035,7 @@ struct device {
>>>> 	spinlock_t		devres_lock;
>>>> 	struct list_head	devres_head;
>>>> 
>>>>+	struct klist_node       knode_class_test_by_rongc;
>>>> 	struct class		*class;
>>>> 	const struct attribute_group **groups;	/* optional groups */
>>>
>>> Hmm... because this is not properly aligned?
>>>
>>> struct klist_node {
>>> 	void			*n_klist;	/* never access directly */
>>> 	struct list_head	n_node;
>>> 	struct kref		n_ref;
>>> };
>>>
>>> Except struct kref has one "int" type, others are pointers.
>>>
>>> But... I am still confused.
>>
>>I guess because the size of struct device is changed, it influences some
>>alignment changes in the system.  Thus influence the benchmark score.
>>
>
> That's interesting.
>
> I wrote a module to see the exact size of these two structure on my x86_64.
>
>     sizeof(struct device) = 736 = 8 * 92
>     sizeof(struct device_private) = 160 = 8 * 20
>     sizeof(struct klist_node) = 32 = 8 * 4
>
> Even klist_node has one 4 byte field, c complier would pack the structure to
> make it aligned. Which system alignment it would affect?
>
> After the patch, size would change like this:
>
>    struct device          736   ->   704
>    struce device_private  160   ->   192
>
> Would this size change affect system?

Yes.  I guess these size change may affect system performance.  Some
other objects may share slab page with these objects.

Best Regards,
Huang, Ying

>>Best Regards,
>>Huang, Ying
>>
>>>>
>>>>Best Regards,
>>>>Rong Chen
