Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0D020882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544162747;
	bh=wZMkMjc/+krb9uIFoG7CBKW/aOM59t+5hkYT8+qZHbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=GwuRx7nWPjVWEdVD1xuSSeB2mXtaLy9QGpW+5e2cy3N1l2rbaKkE2d8WK124EEGbb
	 9/h0DwKIJfSV21TTEnF/pTYnn+UzDYCz8xtMP7YFfZRBC5VgWOLtRpM4emb+GSMUGa
	 vey9IiuN5tyEw01TvKeZmg8VoyZ+tRjKJIF1aKeU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0D020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLGGFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:05:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:54863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGGFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:05:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 22:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="281662781"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2018 22:05:40 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb requests
In-Reply-To: <BL0PR02MB563386B88BDC306AF44EE736A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <SN6PR02MB56484B8D1F891926DA7D7900A7AF0@SN6PR02MB5648.namprd02.prod.outlook.com> <Pine.LNX.4.44L0.1812041420200.1537-100000@iolanthe.rowland.org> <BL0PR02MB563386B88BDC306AF44EE736A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Fri, 07 Dec 2018 08:05:39 +0200
Message-ID: <877eglx45o.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>Does the data book suggest a value for the timeout?
>>
>
> No, the databook doesn't mention about the timeout value
>
>>> >At this point, it seems that the generic approach will be messier than having every
>>> >controller driver implement its own fix.  At least, that's how it appears to me.

Why, if the UDC implementation will, anyway, be a timer?

>>(Especially if dwc3 is the only driver affected.)
>
> As discussed above, the issue may happen with other gadgets too. As I got divide opinions
> on this implementation and both the implementations looks fine to me, I am little confused
> on which should be implemented.
>
> @Felipe: Do you agree with Alan's implementation? Please let us know your suggestion
> on this.

I still think a generic timer is a better solution since it has other uses.

>>> >Ideally it would not be necessary to rely on a timeout at all.
>>> >
>>> >Also, maintainers dislike module parameters.  It would be better not to add one.
>>>
>>> Okay. I would be happy if any alternative for this issue is present but unfortunately
>>> I am not able to figure out any alternative other than timers. If not
>>module_params()
>>> we can add an configfs entry in stream gadget to update the timeout. Please
>>provide
>>> your opinion on this approach.
>>
>>Since the purpose of the timeout is to detect a deadlock caused by a
>>hardware bug, I suggest a fixed and relatively short timeout value such
>>as one second.  Cancelling and requeuing a few requests at 1-second
>>intervals shouldn't add very much overhead.

I wouldn't call this a HW bug though. This is just how the UDC
behaves. There are N streams and host can move data in any stream at any
time. This means that host & gadget _can_ disagree on what stream to
start next.

One way to avoid this would be to never pre-start any streams and always
rely on XferNotReady, but that would mean greatly reduced throughput for
streams.

-- 
balbi
