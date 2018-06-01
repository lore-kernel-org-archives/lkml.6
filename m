Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeFAPHQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:07:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeFAPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:07:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C3A1606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>, Ram Pai <linuxram@us.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
 <CAHp75Vc3YKAR1P_F0fwD+ueGub4gVUjP0=wv4Egf_fTSVkSUjw@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <53e4d6c3-ee19-fd04-4ba3-862d04558689@codeaurora.org>
Date: Fri, 1 Jun 2018 11:06:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc3YKAR1P_F0fwD+ueGub4gVUjP0=wv4Egf_fTSVkSUjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2018 11:02 AM, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 7:34 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Move early dump functionality into common code so that it is available for
>> all archtiectures. No need to carry arch specific reads around as the read
>> hooks are already initialized by the time pci_setup_device() is getting
>> called during scan.
> 
>>  /* If set, the PCIe ATS capability will not be used. */
>>  static bool pcie_ats_disabled;
>>
>> +bool pci_early_dump;
>> +
> 
> I didn't check above these, but maybe a good idea to add one line
> comment what is this about?

This was discussed here: 

https://www.spinics.net/lists/linux-pci/msg72859.html

> 
> 
>>  extern const unsigned char pcie_link_speed[];
>> -
>> +extern bool pci_early_dump;
>>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>>
> 
> Hmm... I would rather not attach this line to some function declarations.

Sure

> 
>> +static void early_dump_pci_device(struct pci_dev *pdev)
>> +{
>> +       u32 value[256 / 4];
>> +       int i;
>> +
>> +       dev_info(&pdev->dev, "pci 0000:%02x:%02x.%d config space:\n",
>> +                pdev->bus->number, PCI_SLOT(pdev->devfn),
>> +                PCI_FUNC(pdev->devfn));
> 
> Shouldn't be this changed to pci_info() ?

Yeah, I need to get used to pci_info().

> 
>> +
>> +       for (i = 0; i < 256; i += 4)
>> +               pci_read_config_dword(pdev, i, &value[i / 4]);
>> +
>> +       print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
>> +                      256, false);
>> +}
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
