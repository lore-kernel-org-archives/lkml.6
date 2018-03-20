Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeCTTSy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:18:54 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33900 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCTTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:18:52 -0400
X-Google-Smtp-Source: AG47ELui4QL8FvuE1fiu1pxYH63J2juN5U1+i5OZ6ytF8ZLFD9QmIBoPWD8yOKjQnqT9RlfcT63EDg==
Date: Tue, 20 Mar 2018 20:18:47 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
Message-ID: <20180320191847.GA23020@casa>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com>
 <20180312205158.GB21621@casa>
 <CAO-hwJJqDM5Y7t-hpZ_s7EzjVki00ME7fd_7iUWcgaTZ9o906g@mail.gmail.com>
 <20180315210659.GA16037@casa>
 <1c75c511-eada-585e-297f-e90feb17ac8c@valvesoftware.com>
 <20180319200813.GA18746@casa>
 <CAM4jgCpNptQz4nP1u0pcBo5fYXJxpxyR4j2U5YBCY2xiev0wug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM4jgCpNptQz4nP1u0pcBo5fYXJxpxyR4j2U5YBCY2xiev0wug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:06:09PM +0100, Clément VUCHENER wrote:
> 2018-03-19 21:08 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>:
> > On Sat, Mar 17, 2018 at 02:54:07PM -0700, Pierre-Loup A. Griffais wrote:
> >
> > Now, what I would really want is a review by Valve of my set-lizard function:
> >
> > static void steam_set_lizard_mode(struct steam_device *steam, bool enabled)
> > {
> >         if (enabled) {
> >                 steam_send_report_byte(steam, 0x8e); //enable mouse
> >                 steam_send_report_byte(steam, 0x85); //enable esc, enter and cursor keys
> >         } else {
> >                 steam_send_report_byte(steam, 0x81); //disable esc, enter and cursor keys
> >                 steam_write_register(steam, 0x08, 0x07); //disable mouse (cmd: 0x87)
> >         }
> > }
> >
> > While it works, I find its asymmetry quite uncanny. I'm afraid that some
> > of these are there for a side effect, this is not their real purpose.
> > Could you give me a hint about this?
> >
> 
> If I remember correctly, you can also enable the mouse with "87 03 08
> 00 00". But that do not explain the asymmetry or why there are two
> ways of doing it. I always found it weird that the "enable" value was
> 0x0000 and the "disable" value 0x0007.

This works fine, thanks. IMO, it is better than command 0x8e.
 I also found that register 0x07 controls the cursor keys emulation:
  * 87 03 07 07 00: disable
  * 87 03 07 03 00: enable (03 or 03
  * 87 03 07 00 00: set "joystick mode" (?)

But I cannot find a similar register to disable the enter/esc keys, for
that I still need commands 0x85 and 0x81. 

Can you tell me if there is a register to configure the enter/esc
emulation? That would be nice, because I could enable disable the lizard
mode with a single report: (87 09 07 07 00 08 07 00 xx 07 00).

Thanks.
Rodrigo
