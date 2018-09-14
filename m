Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94D020853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94D020853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeINSXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:23:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:35734 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbeINSXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:23:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 06:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,373,1531810800"; 
   d="scan'208";a="90034859"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2018 06:05:10 -0700
Subject: Re: [PATCH RFC] scsi: ufs: Disable blk-mq for now
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Janek Kotas <jank@cadence.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Li Wei <liwei213@huawei.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Lemberg <Alex.Lemberg@sandisk.com>
References: <20180913112848.7807-1-adrian.hunter@intel.com>
 <20180913120459.GA4965@ming.t460p>
 <e4d0c716-006a-72cb-0240-4ae5749b21b8@intel.com>
 <20180914015237.GC11059@ming.t460p>
 <2fdfc038-5b86-243c-9b0a-f294d281e5c0@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fe08ad6b-766d-0e13-db66-b2134857131e@intel.com>
Date:   Fri, 14 Sep 2018 16:03:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2fdfc038-5b86-243c-9b0a-f294d281e5c0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/18 09:17, Adrian Hunter wrote:
> On 14/09/18 04:52, Ming Lei wrote:
>> On Thu, Sep 13, 2018 at 03:15:39PM +0300, Adrian Hunter wrote:
>>> On 13/09/18 15:05, Ming Lei wrote:
>>>> On Thu, Sep 13, 2018 at 02:28:48PM +0300, Adrian Hunter wrote:
>>>>> blk-mq does not support runtime pm, so disable blk-mq support for now.
>>>>
>>>> So could you describe a bit what the issue you are trying to fix?
>>>
>>> UFS is a low-power solution, so we must be able to runtime suspend.
>>>
>>>>
>>>> This is host level runtime PM you are trying to address, and if blk-mq
>>>> runtime isn't enabled, I guess the host won't be runtime suspended at all
>>>> because some of its descendant are always active.
>>>>
>>>> So seems we need to do nothing for preventing the host controller from
>>>> entering runtime suspend.
>>>
>>> We don't want to prevent the host controller from runtime suspending, quite
>>> the opposite.
>>
>> OK, got it.
>>
>> However, in previous discussion, it is strongly objected to use
>> per-driver/device .use_blk_mq switch, so not sure if this way can
>> be accepted.
> 
> It is only needed for 4.19 so far.  Otherwise just revert d5038a13eca7
> ("scsi: core: switch to scsi-mq by default")
> 
>>
>> BTW, I just posted the runtime PM enablement patches[1] for blk-mq,
>> and I verified that it works fine and passed blktests & xfstest & my
>> other sanity tests, could you try it on UFS?
>>
>> [1] https://marc.info/?l=linux-block&m=153684095523409&w=2
> 
> I will give it a go.

Yes it seemed to work fine for UFS

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Obviously, if those patches go in, we wouldn't need to disable blk-mq
> anymore, but that isn't until 4.20 at least.
> 

