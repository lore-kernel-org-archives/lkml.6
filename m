Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A697C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A98217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoQeEcs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeLPNcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:32:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42822 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:32:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so9647153wrx.9;
        Sun, 16 Dec 2018 05:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=foIOWubTWcJjX89wRChm+JCGayK4Pml3E/si62uIdBA=;
        b=SoQeEcs5F5cGceHqup3Dq1Ec3EACqns1ABfWRZQ8sZM3bQnoK9EOKEXtPMLwCeSRDO
         2Pbdx2ZtKn84RZd4uKtwYxH52EZV/fSfbOYgIJIXktWqdZ/an/8cQKkyn8lHc0AIkYf0
         fqXmDHv3hIrFa7za5edakU9sykBZM4XEpELrrH/9RKYFL4ZuM+agUnyLulJj2W2ubknU
         Iu0P5fOXymFxRD/4I20zIdj9s1wyBcrifUWhqQd/LNmHnfpYr5IZfWQYIBU/EfrdKoEg
         mvp8KEgolmcvB2/j386bfmvb4jXz/MEd40ZvEToer/nq2ijfL/AXQiDjHZz1oJNYuAjm
         BjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=foIOWubTWcJjX89wRChm+JCGayK4Pml3E/si62uIdBA=;
        b=AyXWr4zbcmyxnoeWfwUqxQfcPTabliu27+k34GeHBCbrsjAKq6GqQilJdZIU4OuvuA
         1eYdR5ry8XQlDT8rQffP0FH/u5Fmb88X0oMVPxQVtYfTDBQ09+gqDLFszh/czTRsjZma
         oiLEuBtRDBS7eQB7tDVYf+5ShnDmjvNUsIOWrdbP0tp5oWsZYaZao8qq+AQS6iGj9LCD
         nlO3qCtflrykP/IbpJ4GLxOKQwAEfWfv1sIHtavMcCN+mqwmu7mf6C04wKSqLjVhlCIk
         twUvYIdGBNeExA9X3O18AJLS+5K1Gpc89ESb8YW/yQuchvtHjNVL+NkEwL4SyyP97Mn3
         tQeQ==
X-Gm-Message-State: AA+aEWbWZdviJ5nROTdIEojF3hI+SgeN8/JDxD0aWdQQs7JWL3F2ZoC7
        6Z8jHhBYkQWH2fYY6LPkHHpe44RiOeM=
X-Google-Smtp-Source: AFSGD/UBEryc2Hc1gQ9pP1p295GdoM1qQnoCTRuhcYGXPxsT/J53CPaUmo+Q5OczJpO04c4A7HUxXQ==
X-Received: by 2002:adf:f504:: with SMTP id q4mr8215888wro.321.1544967159685;
        Sun, 16 Dec 2018 05:32:39 -0800 (PST)
Received: from z3r0 ([31.187.91.78])
        by smtp.googlemail.com with ESMTPSA id e27sm13389229wra.67.2018.12.16.05.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 05:32:39 -0800 (PST)
Message-ID: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
Subject: tpm_tis TPM2.0 not detected on cold boot
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= 
        <niewoehner.michael@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 16 Dec 2018 14:32:38 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

after my UEFI firmware mod/hack to flash the newest available Nuvoton firmware
to the NCPT650 the selftest error went away. Since then the TPM worked without
any further problems, at least after warm reboots.

What I didn't notice before is that it does NOT work after a cold (re)boot.
There is no difference between Intel Firmware TPM and the Nuvoton TPM.
I can reproduce the error for both. I did not test TPM1.2 again.

dmesg warm (re)boot:
--------------------
> dmesg | grep -i tpm
[    0.000000] efi:  ACPI
2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
3.0=0x9ebea000  MEMATTR=0x98fb2018  TPMEventLog=0x972bc018 
[    0.003368] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
S06   00001260 AMI  00000000)
[    3.610138] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)


dmesg cold boot with tpm_tis.interrupts=0 tpm_tis.force=1:
----------------------------------------------------------
> dmesg | grep -i tpm
[    0.000000] Command line: initrd=\initrd-test console=ttyS0,115200n8
break=premount tpm_tis.interrupts=0 tpm_tis.force=1
[    0.000000] efi:  ACPI
2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
3.0=0x9ebea000  MEMATTR=0x98fb2018  TPMEventLog=0x972bb018 
[    0.003531] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
S06   00001260 AMI  00000000)
[    0.162005] Kernel command line: initrd=\initrd-test console=ttyS0,115200n8
break=premount tpm_tis.interrupts=0 tpm_tis.force=1
[    3.616806] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[    3.683117] tpm_tis tpm_tis: can't request region for resource [mem
0xfed40000-0xfed44fff]
[    3.691378] tpm_tis: probe of tpm_tis failed with error -16
[    4.572539] ima: Error Communicating to TPM chip


dmesg cold boot:
----------------
> dmesg | grep -i tpm
[    0.000000] Command line: initrd=\initrd-test console=ttyS0,115200n8
break=premount
[    0.000000] efi:  ACPI
2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
3.0=0x9ebea000  MEMATTR=0x98fb2298  TPMEventLog=0x972bb018 
[    0.003559] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
S06   00001260 AMI  00000000)
[    0.161958] Kernel command line: initrd=\initrd-test console=ttyS0,115200n8
break=premount
[    5.245801] ima: No TPM chip found, activating TPM-bypass!


Any ideas how to debug this?

Thanks
Michael

