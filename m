Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeFDNPm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:15:42 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:57203 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeFDNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:15:40 -0400
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Eric Biggers <ebiggers3@gmail.com>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
CC: Milan Broz <gmazyland@gmail.com>, Alasdair Kergon <agk@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH] md: dm-crypt: Add Inline Encryption support
 for dmcrypt
Thread-Topic: [dm-devel] [PATCH] md: dm-crypt: Add Inline Encryption support
 for dmcrypt
Thread-Index: AQHT9qGCqs8Dj7X7aUOxjJFw2Ba+qw==
Date: Mon, 4 Jun 2018 13:15:35 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020C315@IN01WEMBXA.internal.synopsys.com>
References: <e9120efc-1e25-79c8-6132-9062dd030539@synopsys.com>
 <7a510610-9133-39aa-6841-3925c532f3c0@gmail.com>
 <BD7FB879CC136E419544C8E2AE7B9C3020BB94@IN01WEMBXA.internal.synopsys.com>
 <20180601144625.GA8111@zzz.localdomain>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54DFnU3015755

On Friday 01 June 2018 03:46 PM, Eric Biggers wrote:
> Hi Ladvine,
>
> On Wed, May 30, 2018 at 02:52:07PM +0000, Ladvine D Almeida wrote:
>> On Monday 28 May 2018 05:33 PM, Milan Broz wrote:
>>> On 05/28/2018 03:01 PM, Ladvine D Almeida wrote:
>>>> This patch adds new option
>>>>     -- perform_inline_encrypt
>>>> that set the option inside dmcrypt to use inline encryption for
>>>> the configured mapping. I want to introduce inline encryption support
>>>> in the UFS Host Controller driver. The usage of the same for accomplishing
>>>> the Full Disk Encryption is done by the following changes in the
>>>> dmcrypt subsystem:
>>>>     - New function crypt_inline_encrypt_submit() is added to the
>>>> dmcrypt which associate the crypto context to the bios which
>>>> are submitted by the subsystem.
>>>>     - Successful configuration for the inline encryption will result in
>>>> the crypto transformation job being bypassed in the dmcrypt layer and the
>>>> actual encryption happens inline to the block device.
>>> I am not sure this is a good idea. Dm-crypt should never ever forward
>>> plaintext sector to underlying device.
>>>
>>> And you do not even check that your hw is available in the underlying device!
>>>
>>> If you want to use dm-crypt, write a crypto API driver for your crypto hw that defines
>>> specific cipher and let dm-crypt use this cipher (no patches needed in this case!)
>> Thanks for sharing your review.
>> I am sharing the links for the patches which are related to inline encryption below:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_5_28_1153&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=qwfogRmPFyDoEzG0-jvbwxKzFR6CEey4rqhZlWnAyGg&s=McNQrXeM_-QGjnBJCyJklJ7cBXfcGHLy-JcMFHMq1z0&e=
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_5_28_1196&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=qwfogRmPFyDoEzG0-jvbwxKzFR6CEey4rqhZlWnAyGg&s=t11MogIToXI_6PCllWgf1C16-dSOqNqMIv_T2EK4INw&e=
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_5_28_1158&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=qwfogRmPFyDoEzG0-jvbwxKzFR6CEey4rqhZlWnAyGg&s=28i-jGwv-oAAIrSLGhoPppWb8XY1m32JYPsssF-LvdU&e=
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_5_28_1173&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=qwfogRmPFyDoEzG0-jvbwxKzFR6CEey4rqhZlWnAyGg&s=1KRdmOB67zrJQDYGEAUBvdxBtYI6cPrueQ1PH6Io8g0&e=
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_5_28_1178&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=qwfogRmPFyDoEzG0-jvbwxKzFR6CEey4rqhZlWnAyGg&s=l4PRVW9Oo0QObWye_98AuxGSS3hLhdN5uMKCW-bJZkE&e=
>>
>> we have crypto API implementation for the hardware for  XTS algorithm, which will get registered when
>> the XTS algorithm capability of the inline encryption engine inside UFS Host Controller get detected by the UFS HC
>> driver. dm-crypt will be using this registered cipher.
>>  dm-crypt patch is unavoidable because the encrypt/decrypt function cannot perform the transformation
>> when inline encryption engine is involved. Also, it demands forwarding the plaintext sectors to the underlying
>> block device driver and  the crypto transformation happens internally in controller when data transfer happens.
>>
> I appreciate that you're working on this, but can you please send the full
> series to the relevant mailing lists, so that everyone has the needed context?
> Single random patches for this are basically impossible to review.  OFC that
> also means including a cover letter that explains the overall problem and your
> solution.  In the Cc list I also recommend including the ext4 maintainer
> Theodore Ts'o <tytso@mit.edu>, who led a discussion at LSFMM 2017 about this
> topic (https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_717754_&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=qwfogRmPFyDoEzG0-jvbwxKzFR6CEey4rqhZlWnAyGg&s=x52JiuXr2DWZDm9hObhTwe-He-2waTLXmz9E1Tmz7Y0&e=), and the f2fs maintainer Jaegeuk Kim
> <jaegeuk@kernel.org> who has had to deal with this stuff in an Android device
> kernel, but for another vendor's inline encryption hardware.

Eric, Thanks for your suggestions. I will add the relevant persons in the cc list.

The patches were generated in the below manner:
For block level changes:
https://patchwork.kernel.org/patch/10432255/

For dmcrypt changes for Full Disk Encryption support:
https://lkml.org/lkml/2018/5/28/1027

UFS Host Controller driver changes, patch-series for Inline Encryption support:
https://lkml.org/lkml/2018/5/28/1187 -- cover letter
https://lkml.org/lkml/2018/5/28/1153
https://lkml.org/lkml/2018/5/28/1196
https://lkml.org/lkml/2018/5/28/1158
https://lkml.org/lkml/2018/5/28/1173
https://lkml.org/lkml/2018/5/28/1178


>   I assume your
> solution will work for other vendors too?  I think inline encryption is part of
> the latest UFS specificaton now, so the latest hardware does it in a
> "standardized" way and doesn't require ad-hoc vendor-specific stuff --- right?

Yes, correct. Implementation is done referring to Universal Flash Storage Host Controller Interface(UFSHCI)
document Version 3.0. ** There is no vendor-specific implementation**.
> And do you have any plans for inline encryption support with fscrypt (ext4/f2fs
> encryption, a.k.a. what Android calls "File-Based Encryption")?  We need a
> design for inline encryption in the upstream kernel that is sufficiently general
> to work for all these vendors and use cases, not just specific ones.

Support for the File Based Encryption requires modifications in the fs/crypto in the
similar line as modifications in dmcrypt. But, one challenging thing could be algorithm
implementation is agnostic about the block device with which it is used.
Registered algorithm can be used by filesystem with block device that doesn't have inline encryption
capability. How to identify the same and do a fallback in this case?

>
> Just at a quick glance, you also seem to be abusing the crypto API by exposing
> inline encryption capabilities as a skcipher_alg.  With inline encryption by
> definition you can't actually do encryption outside of a block device request;
> as a result, your patch has to use a fallback algorithm to do the actual
> encryption for the skcipher_alg, which makes no sense.  So it is not at all
> clear to me that you should use the crypto API at all, as opposed to having it
> be purely a block layer thing.  (Please also Cc linux-crypto if you are doing
> significant work related to the crypto API.)

The idea behind registering this way is to support fallback incase the hardware
misses the capability. eg:- when the inline encryption engine cannot perform
transformation using 384bits key for XTS algorithm, it could be accomplished now
using a fallback.
The normal flow for the inline encryption will not make use of the encrypt/decrypt
functions:
    - It use setkey function to identify the key configuration index(when the hardware
        support multiple key slots) and to program the key.
    - the dm-crypt layer bypasses calling the encrypt/decrypt function and passes reference
       to the crypto information in each bio that is submitted by it.
The intention behind implementation as crypto API is to stick to LKCF so that existing utilities
can be used.


>
>>> If I read the patch correctly, you do not check any parameters for
>>> compatibility with your hw support (cipher, mode, IV algorithm, key length, sector size ...)
>> I am registering an algorithm with cipher mode, IV size, block size, supported key size etc. for use by dm-crypt
>> as per the hardware capability of inline encryption engine.
>> If any other cipher mode, etc is used during the setup stage, DM-Crypt will work as normal.
>>
>>> It seems like if the "perform_inline_encrypt" option is present, you just submit
>>> the whole bio to your code with new INLINE_ENCRYPTION bit set.
>> when the optional argument "perform_inline_encrypt" is set, we are not unconditionally sending the bio
>> to the block devices. The steps are explained below:
>> 1. user invokes the dm-setup command with the registered cipher "xts" and with the optional argument
>> "perform_inline_encrypt".
>> 2. dm-setup invokes the setkey function of the newly introduced algorithm, which finds the available key slots
>> to be programmed(UFS Host controller Inline Encryption engine has multiple keyslots), program the key slot,
>> and return the key slot index as return value of the set key function.
>> 3. When read/write operation happens, crypt_map() function in dm-crypt validates whether there is associated
>> key configuration index for the request. The Bio will be submitted directly in this case only with the associated
>> crypto context.
>> 4. Block device driver, eg. UFS host controller driver will create the Transfer requests as per this crypto context and
>> encryption happens inside the controller.
>>
>>> What happens, if the cipher in table is different from what your hw is doing?
>> In this case, the dm-crypt will work as previous. This is because the setkey returns 0.
>> whenever there is key configuration index associated, setkey returns index value(greater than 0). The bios are submitted
>> with that information to underlying block device drivers.
>> Also, care is taken to ensure that fallback will happen incase hardware lacks the support of any key lengths.
>>
>> Appreciate your suggestions/feedback. We are trying to bring modifications into the subsystem to support controllers with
>> inline encryption capabilities and tried our best to take care of any vulnerabilities or risks associated to same.
>> Inline encryption engines got huge advantage over the accelerators/software algorithms that it removes overhead associated
>> to current implementation like performing transformation on 512 byte chunks, allocation of scatterlists etc.
> Thanks,
>
> Eric
>

Best Regards,

Ladvine
