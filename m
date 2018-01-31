Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeAaJIH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:08:07 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34042 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeAaJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:08:01 -0500
X-Google-Smtp-Source: AH8x226g1c1YfnJMBZ5I7sHXUAoOhxpDw4UOJNuo/HGTuj0aTY1LRJbXnSvYwcgKM0lwHbA/Xr9J5A==
Date: Wed, 31 Jan 2018 10:07:58 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Message-ID: <20180131090758.v6eyj35gymlfyzhk@pali>
References: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com>
 <20180130171745.i5wwcwr4qdbcoxhm@pali>
 <CAHp75VcqCdEQjUCoSGz87Mb3HFomfOwKWxC7S2CjtqSAZQEpsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VcqCdEQjUCoSGz87Mb3HFomfOwKWxC7S2CjtqSAZQEpsA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0V98EqG008399

On Tuesday 30 January 2018 20:14:26 Andy Shevchenko wrote:
> >> -static void dell_set_arguments(u32 arg0, u32 arg1, u32 arg2, u32 arg3)
> >> +static void dell_set_arguments(struct calling_interface_buffer *buffer,
> >> +                            u32 arg0, u32 arg1, u32 arg2, u32 arg3)
> >
> > Hm... this function has too many parameters :-(
> >
> > What about following API?
> >
> > static struct calling_interface_buffer dell_set_arguments(u32 arg0, u32 arg1, u32 arg2, u32 arg3);
> >
> > It would return filled structure (not a pointer !)
> 
> I do not think it's a good idea. Either we allocate request on a heap
> and return a pointer, or we fill the struct with some data on spot.
> 
> To naming:
> 
> for allocation: ..._alloc_request()
> for filling: _fill_request() / _prepare_request()
> 
> or alike.
> 
> _set_arguments() not good enough to me.

Ok. Then we need to stick with 5 arguments... What about name
dell_fill_request()? E.g.

  struct calling_interface_buffer buffer;
  dell_fill_request(&buffer, 0x2, 0, 0, 0);
  ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);

-- 
Pali Rohár
pali.rohar@gmail.com
