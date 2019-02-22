Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249052081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfBVKaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:30:25 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42016 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfBVKaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:30:25 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MATN3Z024332;
        Fri, 22 Feb 2019 04:30:20 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2qpgt5tjch-1;
        Fri, 22 Feb 2019 04:30:20 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id B3907611C8AF;
        Fri, 22 Feb 2019 04:30:58 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Feb 2019
 10:30:19 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x1MAUJwY019509;        Fri, 22 Feb 2019 10:30:19 GMT
Date:   Fri, 22 Feb 2019 10:30:19 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jim Broadus <jbroadus@gmail.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client
 device.
Message-ID: <20190222103019.GD130153@ediswmail.ad.cirrus.com>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
 <20190221232609.d4vxl3osj6mwooey@katana>
 <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
 <20190222102335.GA1771@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190222102335.GA1771@kunai>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:23:35AM +0100, Wolfram Sang wrote:
> On Fri, Feb 22, 2019 at 11:15:59AM +0100, Benjamin Tissoires wrote:
> > On Fri, Feb 22, 2019 at 12:26 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > On Tue, Feb 19, 2019 at 11:30:27AM -0800, Jim Broadus wrote:
> > > > A previous change allowed I2C client devices to discover new IRQs upon
> > > > reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
> > > > assigned in i2c_new_device, that information is lost.
> > > >
> > > > For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> > > > are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> > > > client device structures are initialized during an ACPI walk. After
> > > > removing the i2c_hid device, modprobe fails.
> > > >
> > > > This change caches the initial IRQ value in i2c_new_device and then resets
> > > > the client device IRQ to the initial value in i2c_device_remove.
> > > >
> > > > Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> > > > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> > >
> > > Adding Benjamin to CC
> > 
> > Sorry, I should have answered earlier.
> > 
> > I am a little bit hesitant regarding this patch. The effect is
> > correct, and I indeed realized a few weeks ago that something were
> > wrong as we couldn't rmmod/modprobe i2c-hid.
> > 
> > But I still have the feeling that the problem is not solved at the
> > right place. In i2c_new_device() we are storing parts of the fields of
> > struct i2c_board_info, and when resetting the irq we are losing
> > information. This patch solves that, but I wonder if the IRQ should
> > not be 'simply' set in i2c_device_probe(). This means we also need to
> > store the .resources of info, but I have a feeling this will be less
> > error prone in the future.
> > 
> > But this is just my guts telling me something is not right. I would
> > perfectly understand if we want to get this merged ASAP.
> > 
> > So given that the code is correct, this is my:
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > But at least I have expressed my feelings :)
> 
> Which I can relate to very much. I see the code solves the issue but my
> feeling is that we are patching around something which should be handled
> differently in general.
> 
> Is somebody willing to research this further?
> 
> Thanks for your input.
> 

I would be willing to have more of a look at it but am slightly
nervous I am not right person as all the systems I currently work
with are DT based so don't really exemplify the issue at all.

Thanks,
Charles
