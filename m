Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E4EC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA12320855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="e1X88G4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfBHSC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:02:59 -0500
Received: from smtp2.infineon.com ([217.10.52.18]:33528 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBHSC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1549648977; x=1581184977;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=B8F7X7C8DyPdTQ6o+EdfadBAQC7OD4jYvnkZ9TY5acI=;
  b=e1X88G4pVbN42wv9LZF8Sivppv0EgEHE1A0tjRlz3c3Vi98ASKlaa272
   rMYF+oVFZqHYXX4gbMzsa5nucpuk2sDXQcIlfsqHsMEVrpvmevVNyUD/t
   JI+dsOv1hyI8oF1NyWZdGJbRbn93YXL1spO3RsB39cUWdaubpKvGyxV/v
   U=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,9161"; a="100091370"
X-IronPort-AV: E=Sophos;i="5.58,348,1544482800"; 
   d="scan'208";a="100091370"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2019 19:02:56 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  8 Feb 2019 19:02:56 +0100 (CET)
Received: from [10.154.32.28] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1531.3; Fri, 8 Feb
 2019 19:02:55 +0100
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Stefan Berger <stefanb@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
 <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
 <9cd734ad-ea9d-77f7-b657-3f0910a9d92f@linux.ibm.com>
 <515b6c56-59e9-468d-35e0-3ae183bcea8c@infineon.com>
 <20190208140952.GB25255@linux.intel.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <75ea8364-9381-5d2c-6f8c-cb149780c416@infineon.com>
Date:   Fri, 8 Feb 2019 19:02:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208140952.GB25255@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE716.infineon.com (172.23.7.67) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2019 15:09, Jarkko Sakkinen wrote:
> On Fri, Feb 08, 2019 at 02:28:50PM +0100, Alexander Steffen wrote:
>> Applying those changes fixes all the issues I saw, thanks. I'll retest
>> Jarkko's tree without custom patches, once you've agreed on the rc question.
> 
> Just send a two patch patch set how I believe the regression should
> be properly fixed.
> 
> Do not have right now dTPM at hand (the NUC that has one does not
> respond SSH for some reason) so I need help with testing.

Those patches seem to be changing fast :) I'll test them next week.

Alexander
