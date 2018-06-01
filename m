Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeFAG1P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:27:15 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:40921 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeFAG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:27:10 -0400
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Jens Axboe <axboe@kernel.dk>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Manjunath M Bettegowda" <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        "Joao Pinto" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
Thread-Topic: [PATCH] block: Add block level changes for inline encryption
Thread-Index: AQHT9pwpRN+yoa9w10qCAP3oXXj0ew==
Date: Fri, 1 Jun 2018 06:27:04 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020BFC2@IN01WEMBXA.internal.synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <77544032-b6ff-bc5e-9fec-666e66b2cc70@kernel.dk>
 <BD7FB879CC136E419544C8E2AE7B9C3020BD90@IN01WEMBXA.internal.synopsys.com>
 <3fc7786c-af85-d047-047f-44d4eded6124@kernel.dk>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.235]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w516RfG6010187

On Thursday 31 May 2018 04:46 PM, Jens Axboe wrote:
> On 5/31/18 1:47 AM, Ladvine D Almeida wrote:
>> On Monday 28 May 2018 04:54 PM, Jens Axboe wrote:
>>> On 5/28/18 7:43 AM, Ladvine D Almeida wrote:
>>>> This patch introduces new variable under bio structure to
>>>> facilitate inline encryption. This variable is used to
>>>> associate I/O requests to crypto information.
>>> Hard no on this, for two reasons:
>>>
>>> 1) Any additions to struct bio are scrutinized heavily and
>>>    need strong justification.
>> Thanks for sharing your feedback on the patch.
>> I am providing reference to an earlier article related to inline encryption support below:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_717754_&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=m8U0bg9QiswO2oVJgJKq3MmJpqPPK_tN667XwsjojcM&s=9VPcl80YTKwbf8T-oCxWTRahYzS2xNDHZMexpFbuepY&e=
> Took a quick look, and this looks like a classic case of something
> that should just be a cloned bio. If you clone, you own the bi_private
> field, which is what you need.

Cloning the bio gives ownership of the bi_private variable which i can use to refer to the crypto context.
But i have the following problem here:
1. In the dm-crypt subsystem, we clone the bio and assign the bi_private variable. Afterwards, generic_make_request() is done to submit I/O request to block device.
2. The bio will be cloned further in the below layers. The reference in the bi_private variable is now lost as the bio_clone function will not copy the bi_private variable.

Also, the bi_private variable is already used in the dm-crypt layer for storing its private data. This prevents me from using the same.

>

Thanks,

Ladvine
