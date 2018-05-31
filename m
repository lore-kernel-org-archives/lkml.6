Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeEaHrp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:47:45 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:36250 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeEaHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:47:41 -0400
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Jens Axboe <axboe@kernel.dk>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Manjunath M Bettegowda" <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
Thread-Topic: [PATCH] block: Add block level changes for inline encryption
Thread-Index: AQHT9pwpRN+yoa9w10qCAP3oXXj0ew==
Date: Thu, 31 May 2018 07:47:35 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020BD90@IN01WEMBXA.internal.synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <77544032-b6ff-bc5e-9fec-666e66b2cc70@kernel.dk>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4V7m60s025454

On Monday 28 May 2018 04:54 PM, Jens Axboe wrote:
> On 5/28/18 7:43 AM, Ladvine D Almeida wrote:
>> This patch introduces new variable under bio structure to
>> facilitate inline encryption. This variable is used to
>> associate I/O requests to crypto information.
> Hard no on this, for two reasons:
>
> 1) Any additions to struct bio are scrutinized heavily and
>    need strong justification.

Thanks for sharing your feedback on the patch.
I am providing reference to an earlier article related to inline encryption support below:
https://lwn.net/Articles/717754/

In the Existing approach, the crypto transformation happens on the I/O requests before
they are actually submitted to the block level drivers for the payload transfer. This is
accomplished using the software algorithms or crypto accelerators invoked by the
device mapper or the file systems.

The inline encryption engine sits inside the controller(unlike the crypto accelerators). The
challenging part now is that we cannot perform encryption outside controller and there
is a need to communicate this crypto information to the block device drivers so they can
use the same for forming the transfer requests to the controller. This is possible
only by associating the bio to the crypto information, because the crypto context is
different for individual I/O requests.

This modification is generic that it can be used by any host controllers with the inline encryption
engine like UFS Host Controller, Mobile Storage Host Controller etc.

>
> 2) Without an actual use case, any change is always denied.
>    This is just a stand-alone patch.

The Use case is supporting the Inline Encryption Engine inside the UFS Host Controller.
UFS Host Controller has multiple key slots available for use. Each key slot can be used when
we setup disks for encryption using different keys with the device mapper.
When the I/O requests happens on each disks configured, there is a need to associate the bio to
crypto context before submitting the bio to the block layer. UFS Host Controller driver will use this
information from the bio to form the UTRD requests with associated Key ID(different ID for different
key slots). The actual encryption happens inside the controller for the I/O requests making use of the
key programmed in the key slot associated to same.

The List of patches related to the Inline Encryption support are shared below:
https://lkml.org/lkml/2018/5/28/1027
https://lkml.org/lkml/2018/5/28/1153
https://lkml.org/lkml/2018/5/28/1196
https://lkml.org/lkml/2018/5/28/1158
https://lkml.org/lkml/2018/5/28/1173
https://lkml.org/lkml/2018/5/28/1178

The implementation has been tested for Full Disk Encryption using the UFS Host Controller
with inline encryption engine on Synopsys HAPS-70 FPGA-based Prototyping System. We seen
a considerable performance improvement over the traditional approach of using crypto
accelerators that much overhead involved in the device mapper layer can now be avoided.

>
> On top of that, you have it inside BLK_CGROUP, which is
> probably not what you want.

Yes. It has to be corrected.

>
Best Regards,

Ladvine
