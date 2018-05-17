Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeEQMgm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:36:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46032 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:36:41 -0400
Date: Thu, 17 May 2018 14:36:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rick Warner <rick@microway.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bisected] rcu_sched detected stalls - 4.15 or newer kernel with
 some Xeon skylake CPUs and extended APIC
In-Reply-To: <cb8012ab-2599-90fd-ca9f-6d1baeea5b12@microway.com>
Message-ID: <alpine.DEB.2.21.1805171418210.1947@nanos.tec.linutronix.de>
References: <831e8a53-05d1-edfb-6287-fecfba22b8bd@microway.com> <b346f6d2-dd4e-d19b-099e-633045e88f4b@microway.com> <alpine.DEB.2.21.1805152208590.1605@nanos.tec.linutronix.de> <alpine.DEB.2.21.1805161642040.1627@nanos.tec.linutronix.de>
 <cb8012ab-2599-90fd-ca9f-6d1baeea5b12@microway.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rick,

On Wed, 16 May 2018, Rick Warner wrote:

> I've attached the dmesg output with the kernel parameter and supplied patch.

Thanks for providing the data. I think I know what's wrong here. Does the
patch below fix your problem?

While you test, I go looking for a big brown paperbag.

Thanks,

	tglx

8<----------------

--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -124,6 +124,7 @@ static void init_x2apic_ldr(void)
 			goto update;
 	}
 	cmsk = cluster_hotplug_mask;
+	cmsk->clusterid = cluster;
 	cluster_hotplug_mask = NULL;
 update:
 	this_cpu_write(cluster_masks, cmsk);
