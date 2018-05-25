Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966732AbeEYMUw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:20:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966513AbeEYMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:20:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA80960C4F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From: "sayali" <sayalil@codeaurora.org>
To: "'Rob Herring'" <robh@kernel.org>
Cc: <subhashj@codeaurora.org>, <cang@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <rnayak@codeaurora.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <asutoshd@codeaurora.org>,
        <linux-scsi@vger.kernel.org>, "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Mathieu Malaterre'" <malat@debian.org>,
        "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'"
        <devicetree@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1526962900-20683-1-git-send-email-sayalil@codeaurora.org> <1526962900-20683-2-git-send-email-sayalil@codeaurora.org> <20180523184830.GA29198@rob-hp-laptop>
In-Reply-To: <20180523184830.GA29198@rob-hp-laptop>
Subject: RE: [PATCH RFC 1/3] scsi: ufs: set the device reference clock setting
Date: Fri, 25 May 2018 17:50:40 +0530
Message-ID: <000101d3f422$cfae7a20$6f0b6e60$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKWBGBX46Bq7JsJ16hs/xS09lqmJgL6NwMhAka/az+ikjISAA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

For UFS provisioning, all we need is ref_clk to be set to 19.2MHz before
actual descriptor write happens.
So I can actually avoid parsing it via DT and use REF_CLK_FREQ_19_2_MHZ from
enum ref_clk_freq (which is already added in my current implementation).

Thanks,
Sayali
-----Original Message-----
From: Rob Herring [mailto:robh@kernel.org] 
Sent: Thursday, May 24, 2018 12:19 AM
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: subhashj@codeaurora.org; cang@codeaurora.org;
vivek.gautam@codeaurora.org; rnayak@codeaurora.org; vinholikatti@gmail.com;
jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
asutoshd@codeaurora.org; linux-scsi@vger.kernel.org; Mark Rutland
<mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>; open list:OPEN
FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>;
open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] scsi: ufs: set the device reference clock
setting

On Tue, May 22, 2018 at 09:51:38AM +0530, Sayali Lokhande wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> UFS host supplies the reference clock to UFS device and UFS device 
> specification allows host to provide one of the 4 frequencies (19.2 
> MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the 
> device reference clock frequency setting in the device based on what 
> frequency it is supplying to UFS device.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> [cang@codeaurora.org: Resolved trivial merge conflicts]
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  8 +++
>  drivers/scsi/ufs/ufs.h                             |  9 ++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 20 ++++++++
>  drivers/scsi/ufs/ufshcd.c                          | 60
++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                          |  2 +
>  5 files changed, 99 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt 
> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..ac94220 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -41,6 +41,12 @@ Optional properties:
>  -lanes-per-direction	: number of lanes available per direction - either 1
or 2.
>  			  Note that it is assume same number of lanes is
used both
>  			  directions at once. If not specified, default is 2
lanes per direction.
> +- dev-ref-clk-freq	: Specify the device reference clock frequency, must
be one of the following:
> +			  0: 19.2 MHz
> +			  1: 26 MHz
> +			  2: 38.4 MHz
> +			  3: 52 MHz
> +			  Defaults to 26 MHz if not specified.

You already have "ref_clk", can't you just read its frequency?

Rob
