Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525779776; cv=none;
        d=google.com; s=arc-20160816;
        b=gVe8n0Vn9FXlUelj6Ma3XgbPEfZ7+L+tNSu4YQVDLJUSvYsh3Vvoa2ux/ljLAoZVm7
         5BtwdFsczYwgU4U0UFYAkIgq0gIAyjcksa7b3W0w/kCWmMKmD0jIq6WP7PnlMP/IsqIt
         +bQpiPGftwW096JWWQj/pfplTJWpJiVJwOi0t61mgCLD82nosKcHM6maSrxQ2tGdSEci
         7+Vha1Qj/FIt3oiSdIW0Z9I2abcNiBkFwmKeB5Lktq1SxzcU/wvfajYOkIIhcTv0AusT
         MOCW3jeQnrJN+zUOSdzWNxV+T5l4YrMcpMGG7wsunRcKlvXtk/hbNr6SpznFuBfZcer2
         L96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=4D+FPBe14rz8CxlDxp3u+yUB6CxX/NB0EMCAcUy+0q0=;
        b=JKXApdVfwthKkzKWfUJBZh9xhz0EjrjoKUUGBuS/BmxPvq+UzqMp4Wl4az3DFp0B7J
         CzHyto3DivEZwx5zO2sSLn+ebSB7Joi2JXegdsqDTgQqpiXN0tFChvCW7uvOk8ZfLQDQ
         kj0Q2m6gXGR3j9dhDhBx8lypNl3PKV0ZWYZ4BIaIGzNSIRhF3P+L+Msj6aDB5mCkvWno
         Ub6wgf0E/XK53qWwSxj/R6jPLX5qXOAvU2BsQ+DsLHE4mr3G3iYblYHKCRaiAGVFqsdp
         JJf2k2mlFW2J81mbFBI4JfykIPiw1u8oKpyNgf74ZzI5EBYk8N2Fh656h2lOE+en+5bU
         wVSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZo8yLM3Zly8DUwdNj0dS7J1EV+a0quSsMbRX6Oh92IZ5X/1xtWHVTaQnHLzims1qf4JO/jj+Q==
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
To: Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
 linux-kernel@vger.kernel.org
References: <20180502193735.GA2444@zrhn9910b>
 <20180502200615.GB16341@kroah.com> <20180502204612.GA2089@zrhn9910b>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <c589f2f9-e8e3-7f54-e1ab-9ac3baf700bf@redhat.com>
Date: Tue, 8 May 2018 13:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502204612.GA2089@zrhn9910b>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1599896055462115109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Damian,

On 02-05-18 22:46, damian wrote:
> Hello Greg,
> 
> it is PATCH 3 virt: vbox: Use __get_free_pages insteas of kmalloc for DMA32 memory.

Thank you for the bug report, I've tried to reproduce this problem
but for me everything works fine.

Does your virtual-machine have more then 4G of RAM configured for its
use?  If yes then what is likely happening is that you also have
the out-of-tree version of the vboxguest modules installed and prior
to the commit in question the out of tree version of the driver is
loading, because before that commit the vboxguest driver in the
mainline kernel fails to load on machines with more then 4G.

Or alternatively before the commit in question you may not have
any version of the vboxguest driver loaded.

Using the upstream version of the driver should not make a noticeable
difference, but before the vboxguest driver became a part of the
mainline kernel the virtualbox upstream developers have done a
cleanup / redesign of the userspace API of the vboxguest driver,
so the vboxguest driver will only work with recent virtualbox-guest-additions
and since you are using Ubuntu 16.04 chances are that you are
using that with Ubuntu's quite old bundled virtualbox-guest-additions
which will not work with the new driver and may be causing this
issue.

Can you try upgrading your virtualbox-guest-additions to 5.2.10
please?

Also if the above does not help, a couple of follow up
questions to help this pin down further:

1) Are you using vbox's 3d pass through functionality
2) Which desktop-environment are you using?

Regards,

Hans
