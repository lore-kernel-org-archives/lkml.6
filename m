Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeDJONG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:13:06 -0400
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21089 "EHLO
        sender-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeDJOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:13:03 -0400
Date: Tue, 10 Apr 2018 08:12:59 -0600
From: Thomas Fjellstrom <thomas@fjellstrom.ca>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <162afe714f8.b3d0e35172666.3338804793531720120@fjellstrom.ca>
In-Reply-To: 
Subject: Methods to intercept accesses to mmaped page from userspace, or
 pretend to be mmio range
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on a little driver that wants to pretend to be a section of mmio so it can intercept accesses, or intercept accesses to a page after it's been mmaped in by a user space program. So far I haven't found a method that works.

I had been trying to allocate a page, and in the fault handler try and mark the page as readonly, and attempt to check for that in the next fault but as soon as the page is accessed its just assigned now, and there's no more faults (obviously). Other methods include trying ptrace but that seems not accessible from kernel modules, and inserting a uprobe on the instruction after the current one in the fault handler so I can remark the page as readonly but that requires some "clever" platform specific code to parse instructions which I'd prefer not to have to do. I don't really care about intercepting reads, but it might be something I care about at some point. At the very least I'd like to trap all writes, do some magic and then let the access proceede (or emulate it). I looked at providing my own pci bus and device, but I'm not sure that'd actually work.

For some background, I'm trying to emulate the /dev/gpiomem char device from the raspberry pi that lets userspace programs mmap in the gpio registers on the bcm283x SoC.

Is there any way to do what I want to do in a kernel module?

Thanks,

-- 
Thomas Fjellstrom
thomas@fjellstrom.ca
