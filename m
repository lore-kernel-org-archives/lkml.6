Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E074C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5862184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548251762;
	bh=84NIuvcSNDHtc6rbPcLmh1NQz5WLhU8cPh9SxqAnVpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oH9xvNCauVFG4F4KT5+sVjDO8dwsJHftikGJbaExmZwNgMDlZRvjSRNc+3Iz6vBhd
	 etZ64Pv7VyYkgG1CXCE6FcAugeRXchFhHyBCmnLwbaVMzxAp5i1NYX1LiND6cPshHo
	 vZmxIogniEcXoiHsuiKohTxB3xe72dguamVumLwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfAWN4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfAWN4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:56:00 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E18E72184B;
        Wed, 23 Jan 2019 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548251759;
        bh=84NIuvcSNDHtc6rbPcLmh1NQz5WLhU8cPh9SxqAnVpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJN42FUAB4hI9fuJVN1Ex34+cJpqnPoZcQNdOXfttwqSf4EWKN+6LgLpfKEieDtz+
         G1Kbig22RIMpIIelqiND19P0KaW3n/op57JAh46US6Xz9g7lT0ax+iDyCk793ldTn+
         OPuOxUuFK85rGLkKczsspqc+3e9wxs9S1M8zQyrM=
Date:   Wed, 23 Jan 2019 08:55:57 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita 
        <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.20 008/117] platform/x86: asus-wmi: Tell the EC
 the OS will handle the display off hotkey
Message-ID: <20190123135557.GG202535@sasha-vm>
References: <20190108192628.121270-1-sashal@kernel.org>
 <20190108192628.121270-8-sashal@kernel.org>
 <CA+A7VXUA5CGqWMMX_C6sar14f1_TYHxL166bjkMMcW731ndeHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+A7VXUA5CGqWMMX_C6sar14f1_TYHxL166bjkMMcW731ndeHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 04:49:18PM -0800, João Paulo Rechi Vita wrote:
>Hello Sasha,
>
>On Tue, Jan 8, 2019 at 11:26 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: João Paulo Rechi Vita <jprvita@gmail.com>
>>
>> [ Upstream commit 78f3ac76d9e5219589718b9e4733bee21627b3f5 ]
>>
>> In the past, Asus firmwares would change the panel backlight directly
>> through the EC when the display off hotkey (Fn+F7) was pressed, and
>> only notify the OS of such change, with 0x33 when the LCD was ON and
>> 0x34 when the LCD was OFF. These are currently mapped to
>> KEY_DISPLAYTOGGLE and KEY_DISPLAY_OFF, respectively.
>>
>> Most recently the EC on Asus most machines lost ability to toggle the
>> LCD backlight directly, but unless the OS informs the firmware it is
>> going to handle the display toggle hotkey events, the firmware still
>> tries change the brightness through the EC, to no effect. The end result
>> is a long list (at Endless we counted 11) of Asus laptop models where
>> the display toggle hotkey does not perform any action. Our firmware
>> engineers contacts at Asus were surprised that there were still machines
>> out there with the old behavior.
>>
>> Calling WMNB(ASUS_WMI_DEVID_BACKLIGHT==0x00050011, 2) on the _WDG device
>> tells the firmware that it should let the OS handle the display toggle
>> event, in which case it will simply notify the OS of a key press with
>> 0x35, as shown by the DSDT excerpts bellow.
>>
>>  Scope (_SB)
>>  {
>>      (...)
>>
>>      Device (ATKD)
>>      {
>>          (...)
>>
>>          Name (_WDG, Buffer (0x28)
>>          {
>>              /* 0000 */  0xD0, 0x5E, 0x84, 0x97, 0x6D, 0x4E, 0xDE, 0x11,
>>              /* 0008 */  0x8A, 0x39, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66,
>>              /* 0010 */  0x4E, 0x42, 0x01, 0x02, 0x35, 0xBB, 0x3C, 0x0B,
>>              /* 0018 */  0xC2, 0xE3, 0xED, 0x45, 0x91, 0xC2, 0x4C, 0x5A,
>>              /* 0020 */  0x6D, 0x19, 0x5D, 0x1C, 0xFF, 0x00, 0x01, 0x08
>>          })
>>          Method (WMNB, 3, Serialized)
>>          {
>>              CreateDWordField (Arg2, Zero, IIA0)
>>              CreateDWordField (Arg2, 0x04, IIA1)
>>              Local0 = (Arg1 & 0xFFFFFFFF)
>>
>>              (...)
>>
>>              If ((Local0 == 0x53564544))
>>              {
>>                  (...)
>>
>>                  If ((IIA0 == 0x00050011))
>>                  {
>>                      If ((IIA1 == 0x02))
>>                      {
>>                          ^^PCI0.SBRG.EC0.SPIN (0x72, One)
>>                          ^^PCI0.SBRG.EC0.BLCT = One
>>                      }
>>
>>                      Return (One)
>>                  }
>>              }
>>              (...)
>>          }
>>          (...)
>>      }
>>      (...)
>>  }
>>  (...)
>>
>>  Scope (_SB.PCI0.SBRG.EC0)
>>  {
>>      (...)
>>
>>      Name (BLCT, Zero)
>>
>>      (...)
>>
>>      Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
>>      {
>>          If ((BLCT == Zero))
>>          {
>>              Local0 = One
>>              Local0 = RPIN (0x72)
>>              Local0 ^= One
>>              SPIN (0x72, Local0)
>>              If (ATKP)
>>              {
>>                  Local0 = (0x34 - Local0)
>>                  ^^^^ATKD.IANE (Local0)
>>              }
>>          }
>>          ElseIf ((BLCT == One))
>>          {
>>              If (ATKP)
>>              {
>>                  ^^^^ATKD.IANE (0x35)
>>              }
>>          }
>>      }
>>      (...)
>>  }
>>
>> Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>I am not entirely sure this is linux-stable material. This patch makes
>the "turn off the display backlight" hotkey work on some Asus machines
>where, without this patch, the key would simply do nothing. It seems
>to me this is more of a new feature support than a bug fix. That said,
>if you or Andy think this should go to stable after this short
>explanation, I'll not object it.

I think I'll keep this in. It looks a lot like a quirk to make this
device work.

--
Thanks,
Sasha
