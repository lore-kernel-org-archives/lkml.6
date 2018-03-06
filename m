Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AG47ELs97loJYJOP4k2F3k/ggGryqdlgx8fVO8IiVdDA0m44Ww1ZSP2hCkI9dRitwMFZUId4UOPx
ARC-Seal: i=1; a=rsa-sha256; t=1520335324; cv=none;
        d=google.com; s=arc-20160816;
        b=NXk1+3qMdRZeNsSNh8S0F/G4FIA+6tcVTo9LGPNRtrolxHCXw0TG5AZ2NWyOvjnAzM
         AxNSXrpxzFp/haxrazTqu7us892NPOTbzBoWPXdFnuyNWptw0+pr+v18LdxJMmGjWNpk
         kje+cGniROwfUrlFFEK2M+N1sTd3FfmLFi/CYlvg0onG9Hddi3X1IfJ9648pDScjKRYm
         vNuuXraXDIlgFtW5zXHZS9OeaSBIGs49cMKY1z6KF6ofBwgcG0IqHRdB0XpsGYh/KN+k
         FTLD/c78aCaYi1yT+IiG18xv3ErXBUDEJX+OTff8KYSsGYnI2FbAJeYwRoNmSGBxGPhn
         u9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=TB6lgts4pO9TIYbD1ZYekWMl/z/qfN3drfaZj8XFQus=;
        b=NqkgIDQLh3EWGABE5wO62/XSdz0EPICWYMr1H1y3XPU5HhEhv3RJfFW8obm/AZzagR
         yakI8dNsObLgpDoFphLCRx2fI2WZlUlkDMBPFaeVSLBo6R2lDE5unLtLwKd3mvGs9I7z
         RkgzFUf3MLtf+08FxdwuBvMyCQn8T//g/lK+1dI+QdFbxf18pPHXJZwvz10fl6/7ZXVv
         mF7XPOcnckU3a9Oziv2sgFQNvlLPDJiEdBGtoEjBE28GQvkfbBA9AShrcKdMY+AaVTQf
         SDenss3Ksbu+VaU3NfILAPtG+wQ+m7TSyg/XBqEMTXviU/Qva3ofXzoxsuPvLeRpVocO
         WGMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="22167358"
Message-ID: <1520335317.10722.416.camel@linux.intel.com>
Subject: Re: [PATCH v16 0/9]  LPC: legacy ISA I/O support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, mika.westerberg@linux.intel.com,
 rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
 hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
 arnd@arndb.de,  mark.rutland@arm.com, olof@lixom.net,
 dann.frazier@canonical.com,  andy.shevchenko@gmail.com, robh@kernel.org
Cc: joe@perches.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxarm@huawei.com,  minyard@acm.org, devicetree@vger.kernel.org,
 linux-arch@vger.kernel.org,  rdunlap@infradead.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 frowand.list@gmail.com, agraf@suse.de
Date: Tue, 06 Mar 2018 13:21:57 +0200
In-Reply-To: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594185012385637551?=
X-GMAIL-MSGID: =?utf-8?q?1594187133546427382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-03-06 at 18:47 +0800, John Garry wrote:
> This patchset supports the IPMI-bt device attached to the Low-Pin-
> Count
> interface implemented on Hisilicon Hip06/Hip07 SoC.
>                         -----------
>                         | LPC host|
>                         |         |
>                         -----------
>                              |
>                 _____________V_______________LPC
>                   |                       |
>                   V                       V
>                                      ------------
>                                      |  BT(ipmi)|
>                                      ------------
> 
> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a
> specific
> LPC driver is needed to make LPC host generate the standard LPC I/O
> cycles with
> the target peripherals'I/O port addresses. But on curent arm64 world,
> there is
> no real I/O accesses. All the I/O operations through in/out accessors
> are based
> on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed
> through driver
> specific accessors rather than MMIO.
> To solve this issue and keep the relevant existing peripherals'
> drivers untouched,
> this patchset:
>    - introduces a generic I/O space management framework, logical PIO,
> to support
>       I/O operations on host controllers operating either on MMIO
> buses or on buses
>      requiring specific driver I/O accessors;
>    - redefines the in/out accessors to provide a unified interface for
> both MMIO
>      and driver specific I/O operations. Using logical PIO, th call of
> in/out() from
>      the host children drivers, such as ipmi-si, will be redirected to
> the
>      corresponding device-specific I/O hooks to perform the I/O
> accesses.
> 
> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
> peripherals can
> be supported without any changes on the existing ipmi-si driver.
> 
> The whole patchset has been tested on Hip07 D05 board both using DTB
> and ACPI.
> 

> V15 thread here: https://lkml.org/lkml/2018/2/26/584

Thanks for an update.
Though I answered to previous thread.

Summary: I'm fine with the series as long as maintainers are fine
(Rafael et al.). On personal side I think that the handler approach is
better. Details are in v15 thread.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
