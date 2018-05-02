Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeEBBaF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:30:05 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:55290
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751080AbeEBBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:30:03 -0400
X-ASG-Debug-ID: 1525224596-093b7e542b2b09d0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] efi/capsule-loader: Don't output reset log when header
 flags is not set
Thread-Topic: [PATCH] efi/capsule-loader: Don't output reset log when header
 flags is not set
X-ASG-Orig-Subj: Re: [PATCH] efi/capsule-loader: Don't output reset log when header
 flags is not set
Thread-Index: AQHT3EMNtQaava5F1ky8EAu16HEtD6QaJhQAgAEFbgA=
Date: Wed, 2 May 2018 01:29:55 +0000
Message-ID: <1525224594.2901.4.camel@hxt-semitech.com>
References: <1524625806-23133-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <CAKv+Gu89B-E+L2qybT9n5j72c+1vm1az4H9Cp7E71aP3i3VE6A@mail.gmail.com>
In-Reply-To: <CAKv+Gu89B-E+L2qybT9n5j72c+1vm1az4H9Cp7E71aP3i3VE6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.16]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <61C00092B24DA84CA2D1348016E5D5D3@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1525224596
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4776 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.50503
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ard,

On Tue, 2018-05-01 at 11:54 +0200, Ard Biesheuvel wrote:
> On 25 April 2018 at 05:10, Shunyong Yang <shunyong.yang@hxt-semitech.
> com> wrote:
> > 
> > It means firmware attempts to immediately process or launch the
> > capsule
> > when flags in capsule header is not set. Moreover, reset is not
> > needed
> > in this case. Current code will output log to indicate reset.
> > 
> > This patch adds a branch to avoid reset log output when the flags
> > is not
> > set.
> > 
> > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > ---
> >  drivers/firmware/efi/capsule-loader.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/capsule-loader.c
> > b/drivers/firmware/efi/capsule-loader.c
> > index e456f4602df1..a63b8e5bde23 100644
> > --- a/drivers/firmware/efi/capsule-loader.c
> > +++ b/drivers/firmware/efi/capsule-loader.c
> > @@ -134,10 +134,15 @@ static ssize_t
> > efi_capsule_submit_update(struct capsule_info *cap_info)
> > 
> >         /* Indicate capsule binary uploading is done */
> >         cap_info->index = NO_FURTHER_WRITE_ACTION;
> > -       pr_info("Successfully upload capsule file with reboot type
> > '%s'\n",
> > -               !cap_info->reset_type ? "RESET_COLD" :
> > -               cap_info->reset_type == 1 ? "RESET_WARM" :
> > -               "RESET_SHUTDOWN");
> > +
> > +       if (cap_info->header.flags)
> You should check for the relevant flag bits here, because the 16
> lower
> bits are platform dependent.
In current three bits in flags, CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE and
CAPSULE_FLAGS_INITIATE_RESET are dependent on
CAPSULE_FLAGS_PERSIST_ACROSS_RESET.

So, maybe I only need to check CAPSULE_FLAGS_PERSIST_ACROSS_RESET?

Thanks.
Shunyong.
> 
> > 
> > +               pr_info("Successfully upload capsule file with
> > reboot type '%s'\n",
> > +                       !cap_info->reset_type ? "RESET_COLD" :
> > +                       cap_info->reset_type == 1 ? "RESET_WARM" :
> > +                       "RESET_SHUTDOWN");
> > +       else
> > +               pr_info("Successfully upload, process and launch
> > capsule file\n");
> > +
> >         return 0;
> >  }
> > 
> > --
> > 1.8.3.1
> > 
