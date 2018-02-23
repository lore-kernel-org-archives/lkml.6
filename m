Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeBWW2R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:28:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41800 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeBWW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:28:13 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        tglx@linutronix.de
Subject: iommu/amd: lock splitting & GFP_KERNEL allocation
Date: Fri, 23 Feb 2018 23:27:26 +0100
Message-Id: <20180223222736.18542-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have no idea why but suddenly my A10 box complained loudly about
locking and memory allocations within the iommu code under RT. Looking
at the code it has been like this for a longer time so the iommu must
have appeared recently (well there was a bios upgrade due to other
issues so it might have enabled it).

The goal here is to make the memory allocation in get_irq_table() not
with disabled interrupts and having as little raw_spin_lock as possible
while having them if the caller is also holding one (like desc->lock
during IRQ-affinity changes).

The patches were boot tested on an AMD EPYC 7601.

Sebastian
