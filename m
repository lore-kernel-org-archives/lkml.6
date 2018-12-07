Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C066520837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544163114;
	bh=V9R8FG/Y+o7b3OTIQsDCzQrd1DS1egX20HLDZyAvgEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=MiFQG+/yq8+PdCiAo14yOlRWyFgIF/58Weo7ALjoIyjT8eizy04GScrGDJ6pCeRYp
	 Jg+Na/sTUPocyA1ubZgo3y1IcmwZ4M9oO6q1jifJWh4Rs8VDpPBRB9b0pM2WAQ5zBs
	 aaA+9t9ULHcAjAQijthGMcQss0t7kq+n0HaNiQbU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C066520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLGGLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:11:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:38895 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGGLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:11:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 22:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="123764889"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2018 22:11:48 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
In-Reply-To: <BL0PR02MB563352F83A80E3B92347A7A4A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com> <875zw82vfj.fsf@linux.intel.com> <BL0PR02MB563352F83A80E3B92347A7A4A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Fri, 07 Dec 2018 08:11:47 +0200
Message-ID: <874lbpx3vg.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>> @@ -2286,7 +2286,12 @@ static int
>>dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
>>>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)
>>>  		return 1;
>>>
>>> -	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
>>> +	if ((event->status & DEPEVT_STATUS_IOC) &&
>>> +	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
>>> +		return 1;
>>
>>this shouldn't be necessary. According to databook, event->status
>>contains the bits from the completed TRB.  Which means that
>>event->status & IOC will always be equal to trb->ctrl & IOC.
>>
> Thanks for reviewing this patch. Lets consider an example where a request
> has num_sgs > 0 and each sg is mapped to a TRB and the last TRB has the
> IOC bit set. Once the controller is done with the transfer, it  generates 
> XferInProgress for the last TRB (since IOC bit is set). As a part of trb reclaim
> process  dwc3_gadget_ep_reclaim_trb_sg() calls
> dwc3_gadget_ep_reclaim_completed_trb() for req->num_sgs times. Since
> the event already has the IOC bit set, the loop is exited from the loop at the
> very first TRB and the remaining TRBs (mapped to the sglist) are left unhandled.
> To avoid this we modified the code to exit only if both TRB & event has the IOC
> bit set.

Seems like IOC case should just test for chain flag as well:

modified   drivers/usb/dwc3/gadget.c
@@ -2372,7 +2372,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & DEPEVT_STATUS_IOC && !chain)
 		return 1;
 
 	return 0;

-- 
balbi
