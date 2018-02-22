Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AH8x225Akygfx8p+bm3tmSysi7DgbgluN1bo9gHHmZ2wGSjcZ7/TDUhAm35pkreF6SnFDmr6dF5t
ARC-Seal: i=1; a=rsa-sha256; t=1519335824; cv=none;
        d=google.com; s=arc-20160816;
        b=x4ZxmqeoYxVF2wTAMAbliOohZdHLfNOpTGSE2Zs0kh0igDRhRrIMi4BYHwrJAG7F6X
         NPMiqAVhbq2tGoWvcMJJXlCvGH09tuYZCuYmzy+7OB4F+akM7X36R8tYRayspvQC4n8z
         JFHjskCnhukWvCUZ+HGqfV25G1De5E9sl5Zpvdry2EXnYTO2yhYMBcF2ps5lwu+U/udF
         MkN4UQz+z8jD7gqW6mC4Tv+5VB90M9haiPm66/IOVxeZpVNzB8di10DNL8C6lbcuyS0k
         7NdY+I/vpb+slJfMY4VbzcK4lrA0mmF9L7EwQXGm5aEuJMEsUVWmQs57dXMfMEYddE1H
         8arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=0peQ6pzgklE5+EqWpxpe+4jh61ED41fhatKxFnbvNfM=;
        b=FmnQauCS7t+gZ9NoznFZZKfTm21Nw95vulGw9JJBHzy8BNVDIqP5fsHkppeS9O+YTf
         UaqhRpL6F5VorL4e5ma+pSk0so8bTU8iBMRpmDJyu5+JEoxXIzteMLt6SmHn/jTaGNzi
         quii2TjPsoRAmHvfO1Ez2cYzEak885mgX6KHvWXUqMGmrEn5LL+QtAdJVuPChf9fmNYb
         CiPcXVl4f2FDDvuCs6xRslJLoZflecYulVJYsRgZvkzFaOAw1ngK+U58/mJEYtxEm8JS
         5j60Q22E07sYhq5esvPjF7K/qgncDumnAHHMNX7s1hx1IrSh9HQ/VW+dZ0MixHYHDyZf
         Mcng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F7620C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180130074131.GD25976@kroah.com>
References: <1516898344-20020-1-git-send-email-richard.gong@linux.intel.com>
 <20180125165352.GA21640@kroah.com> <7e01745c-24aa-62f7-0be9-f74f19d6d880@linux.intel.com>
 <20180130074131.GD25976@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 22 Feb 2018 15:43:02 -0600
X-Gmail-Original-Message-ID: <CANk1AXRijdZQ7YYBvDjrEf2TG31iNZuf9fbcjgvzJaUkMsMk9A@mail.gmail.com>
Message-ID: <CANk1AXRijdZQ7YYBvDjrEf2TG31iNZuf9fbcjgvzJaUkMsMk9A@mail.gmail.com>
Subject: Re: [PATCHv1] Add Intel Stratix10 service layer driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, arnd@arndb.de,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Yves Vandervennet <yves.vandervennet@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590583065067005929?=
X-GMAIL-MSGID: =?utf-8?q?1593139081749792365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 30, 2018 at 1:41 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jan 29, 2018 at 08:08:11PM -0600, Richard Gong wrote:
>> Hi Greg,
>>
>> Many thanks for your reviews.
>>
>>
>> On 01/25/2018 10:53 AM, Greg KH wrote:
>> > On Thu, Jan 25, 2018 at 10:39:03AM -0600, richard.gong@linux.intel.com wrote:
>> > > From: Richard Gong <richard.gong@intel.com>
>> > >
>> > > Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
>> > > processor system (HPS) and Secure Device Manager (SDM). SDM is the hardware
>> > > which does the FPGA configuration, QSPI, Crypto and warm reset.
>> > >
>> > > When the FPGA is configured from HPS, there needs to be a way for HPS to
>> > > notify SDM the location and size of the configuration data. Then SDM will
>> > > get the configuration data from that location and perform the FPGA configuration.
>> > >
>> > > To meet the whole system security needs and support virtual machine
>> > > requesting communication with SDM, only the secure world of software (EL3,
>> > > Exception Level 3) can interface with SDM. All software entities running
>> > > on other exception levels must channel through the EL3 software whenever it
>> > > needs service from SDM.
>> > >
>> > > Intel Stratix10 service layer driver is added to provide the service for
>> > > FPGA configuration. Running at privileged exception level (EL1, Exception
>> > > Level 1), Intel Stratix10 service layer driver interfaces with the service
>> > > provider at EL1 (Intel Stratix10 FPGA Manager) and manages secure monitor
>> > > call (SMC) to communicate with secure monitor software at secure monitor
>> > > exception level (EL3).
>> > >
>> > > Later the Intel Stratix10 service layer driver will be extended to provide
>> > > services for QSPI, Crypto and warm reset.
>> > >
>> > > Richard Gong (1):
>> > >    driver: misc: add Intel Stratix10 service layer driver
>> > >
>> > >   drivers/misc/Kconfig                       |   3 +-
>> > >   drivers/misc/Makefile                      |   3 +-
>> > >   drivers/misc/intel-service/Kconfig         |   9 +
>> > >   drivers/misc/intel-service/Makefile        |   2 +
>> > >   drivers/misc/intel-service/intel_service.c | 703 +++++++++++++++++++++++++++++
>> > >   include/linux/intel-service-client.h       | 227 ++++++++++
>> > >   include/linux/intel-service.h              | 122 +++++
>> > >   include/linux/intel-smc.h                  | 246 ++++++++++
>> > Simple questions first:
>> >   - why do you have 3 different .h files for a single .c file?
>> This is because service layer driver interface with both the service
>> provider and secure monitor SW.
>> intel-service-client.h is created to define interface between service
>> providers (FPGA manager is one of them) and service layer. Alan Tull's FPGA
>> manager .c file includes this header file
>> intel-smc.h defines the secure monitor call (SMC) message protocols used for
>> service layer driver in normal world (EL1) to communicate with secure
>> monitor SW in secure monitor exception level 3 (EL3). Also this header file
>> is shared with firmware since both (FW, service layer) utilizes the same SMC
>> message protocol.
>> intel-sevice.h is created to define service layer's own data structures
>> (service controller, channel for communicating with service provider, shared
>> memory region, private data etc)
>
> That's very complex for a single patch submission, don't you think?

Hi Greg,

I'm reviewing this patchset now.  v2 will simplify things down and add
better documentation.  Only 2 headers (one for the client API and one
to define the interface with the out of tree code this talks to).

>
> Please do not add new apis / interfaces for code that is not part of
> your patch series, otherwise we don't know what the future is going to
> hold :)

The v2 patch set will include my FPGA manager driver which is the
first client of this service.  My driver will use all the API
functions exported by this service driver.

>
> This feels like it should be a series of patches, to properly explain
> this and hook up all of the new interfaces you are adding, right?

There will be other clients, so there will be other patchsets on top
of this.  We'll be sure to include new API functions and the client
that needs them in the same patch set in the future.

Thanks for your feedback, helpful as always!

Alan

>
> thanks,
>
> greg k-h
