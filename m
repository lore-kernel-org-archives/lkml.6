Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803846-2-14184970317261280019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803846; b=PLt+NjLquwofVWVSN0DtgVOk+HZRReZbzRMV/x4vxfaxTkP
    P+E2JIY0XoeflewmzRzdr1hvZm9e7uxgWbFMQJHkwtycL1h2iJBdgNUNpzZc27YP
    pvptZ/ii2Fttd4+C7dzcmx5soYoC3W+t4cuLGiaI197Qfr1rOcF1tApH0XssKzK1
    ojC49fokb8z8P7cxnci+H1hLgS711gzxmY26/gWRQmQTarWKYOOZqrX0Nman/wK1
    MTR5kEqFDVkNekGN16IqbtJ1bfuwv6r7AsvNBImyLi3v0/xgrU3ipSGQTxTi0A0r
    h+EAY7/MpipQwsekW+w2uqnbPGnYlSXvnK7hjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803846; bh=kH50jOqOekJac+jGdngyPjkrvg
    Qsk9p3ezhM8VABLds=; b=Ro1ggm0/IOKKoL9qM6Q+9bjchXNNusgjLZjS43e127
    K8k09TkEXwqpxoCbQgb6xZdQbuNwZ6Vu8sZgTPpH9O2iVNUktAlYQrFlIFfrHSo1
    M/JkaSPUQLsPLV6uCFjfQeCvHwxif/aCRs4T0E/jHgNx4lwhv/RxOXp/gfiUgFU6
    +4KaCFoznrCMP1ts/zr4/sFklc0rSb7X3HZClcgvtRzeRhZXCOOdZPzkOZT35PQs
    Aza4LDii7g0LoL4oKTt2gjKk4lpQ+mA0lfiems9wxuy6swY3Tins+j00p4qLPgKl
    zAkAYWN8Aa9nCbebkh3MDmVJ2m/j6jSZQhHkd+IvbnYQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeCWLRK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:17:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932461AbeCWKJ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 117/177] ACPI / power: Delay turning off unused power resources after suspend
Date: Fri, 23 Mar 2018 10:54:05 +0100
Message-Id: <20180323094210.419860029@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 8ece1d83346bcc431090d59a2184276192189cdd ]

Commit 660b1113e0f3 (ACPI / PM: Fix consistency check for power resources
during resume) introduced a check for ACPI power resources which have
been turned on by the BIOS during suspend and turns these back off again.

This is causing problems on a Dell Venue Pro 11 7130 (i5-4300Y) it causes
the following messages to show up in dmesg:

[  131.014605] ACPI: Waking up from system sleep state S3
[  131.150271] acpi LNXPOWER:07: Turning OFF
[  131.150323] acpi LNXPOWER:06: Turning OFF
[  131.150911] acpi LNXPOWER:00: Turning OFF
[  131.169014] ACPI : EC: interrupt unblocked
[  131.181811] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
[  133.535728] pci_raw_set_power_state: 76 callbacks suppressed
[  133.535735] iwlwifi 0000:01:00.0: Refused to change power state,
               currently in D3
[  133.597672] PM: noirq resume of devices complete after 2428.891 msecs

Followed by a bunch of iwlwifi errors later on and the pcie device
dropping from the bus (acpiphp thinks it has been unplugged).

Disabling the turning off of unused power resources fixes this. Instead
of adding a quirk for this system, this commit fixes this by moving the
disabling of unused power resources to later in the resume sequence
when the iwlwifi card has been moved out of D3 so the ref_count for
its power resource no longer is 0.

This new behavior seems to match the intend of the original commit which
commit-msg says: "(... which means that no devices are going to need them
any time soon) and we should turn them off".

This also avoids power resources which we need when bringing devices out
of D3 from getting bounced off and then back on again.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/power.c |   10 ++++++++++
 drivers/acpi/sleep.c |    1 +
 drivers/acpi/sleep.h |    1 +
 3 files changed, 12 insertions(+)

--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -864,6 +864,16 @@ void acpi_resume_power_resources(void)
 
 		mutex_unlock(&resource->resource_lock);
 	}
+
+	mutex_unlock(&power_resource_list_lock);
+}
+
+void acpi_turn_off_unused_power_resources(void)
+{
+	struct acpi_power_resource *resource;
+
+	mutex_lock(&power_resource_list_lock);
+
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
 		int result, state;
 
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -474,6 +474,7 @@ static void acpi_pm_start(u32 acpi_state
  */
 static void acpi_pm_end(void)
 {
+	acpi_turn_off_unused_power_resources();
 	acpi_scan_lock_release();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -6,6 +6,7 @@ extern struct list_head acpi_wakeup_devi
 extern struct mutex acpi_device_lock;
 
 extern void acpi_resume_power_resources(void);
+extern void acpi_turn_off_unused_power_resources(void);
 
 static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
 {
