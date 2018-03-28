Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeC1Q2C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:28:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeC1Q2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:28:01 -0400
Date: Wed, 28 Mar 2018 13:27:54 -0300
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        Brian Warner <brian.warner@samsung.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: CVE-2017-13166 fixes for Kernel 3.18 - was: Re: Linux 3.18.102
Message-ID: <20180328132754.7fbda70c@vento.lan>
In-Reply-To: <20180327083054.1d9b7796@vento.lan>
References: <CGME20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1@epcas1p2.samsung.com>
        <20180325085952.GA31575@kroah.com>
        <5AB9A111.1080105@samsung.com>
        <20180327070528.GB31193@kroah.com>
        <5AB9F365.2030309@samsung.com>
        <20180327083054.1d9b7796@vento.lan>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SGS5q9029256

Em Tue, 27 Mar 2018 08:30:54 -0300
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> Em Tue, 27 Mar 2018 16:31:49 +0900
> Seung-Woo Kim <sw0312.kim@samsung.com> escreveu:
> 
> > On 2018년 03월 27일 16:05, Greg KH wrote:
> > > On Tue, Mar 27, 2018 at 10:40:33AM +0900, Seung-Woo Kim wrote:  
> > >> Hello,
> > >>
> > >> Until 3.18.102, it looks like following patch series for v4l2 seems missed.
> > >>
> > >> 273caa2 media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
> > >> a1dfb4c media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic
> > >> d83a824 media: v4l2-compat-ioctl32.c: don't copy back the result for
> > >> certain errors
> > >> 169f24c media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
> > >> a751be5 media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
> > >> b8c601e media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
> > >> 8ed5a59 media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
> > >> 333b1e9 media: v4l2-compat-ioctl32.c: avoid sizeof(type)
> > >> 486c521 media: v4l2-compat-ioctl32.c: move 'helper' functions to
> > >> __get/put_v4l2_format32
> > >> b7b957d media: v4l2-compat-ioctl32.c: fix the indentation
> > >> 3ee6d04 media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
> > >> 181a4a2 media: v4l2-ioctl.c: don't copy back the result for -ENOTTY  
> > > 
> > > That is correct.
> > >   
> > >> Any plan to apply the series?  
> > > 
> > > Do you have a backported version of this series that will apply to that
> > > kernel tree?  If so, I'll be glad to apply it but I'm pretty sure the
> > > reason I did not apply them was because they did not apply correctly.  
> > 
> > I dit not do it myself. I just checked the series is applied on other
> > stable trees.
> 
> Backporting it from Kernel 4.1 is quite simple. Just two patches
> have trivial conflicts.
> 
> I did a quick backport at:
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=v3.18.102%2bCVE
> 
> Please notice that I didn't test it yet.
> 
> Will build such Kernel and see how it behaves with compat32.
> 
> If it works fine, I'll submit for stable.

Hi Seung-Woo,

I did some tests here with the vivid driver and v4l2-compliance tool.

I had to apply a few fixes on the top of the 4.1 patchset.
With those fixes, compat32 is working fine with Kernel 3.18.102 on my
test environment.

Feel free to use it on your tree. The patches are under the
top of 3.18.102, on my development tree:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=v3.18.102%2bCVE

It should be noticed that 5 other patches are required for it to
work at Kernel 3.18 and to make v4l2-compliance to produce the same
results on both 32 bits and 64 bits version.

Those two are backports from upstream and contains some control fixes
applied at Kernel 4.1:

	1663cf48e2eb media: media/v4l2-ctrls: volatiles should not generate CH_VALUE
	d53d22eb0ea4 media: v4l2-ctrls: fix sparse warning

This patch fix an extra issue with compat32 code that is specific to
Kernel 3.18, and backports a change that also happened upstream:

	2ba950543618 media: v4l2-compat-ioctl32: use compat_u64 for video standard

Those 2 patches are required to fix some issues that I suspect that also
affect upstream patches:

	acf19bbe76c5 media: v4l2-compat-ioctl32: initialize a reserved field
	ccaf872a9873 media: v4l2-compat-ioctl32: don't oops on overlay

However, I didn't test with other Kernel versions yet. Such patches should 
go through the usual review at media ML.

After having them reviewed and applied upstream (if needed),  I'll submit 
the entire series for Greg to pick for Kernel 3.18.

Regards,
Mauro
