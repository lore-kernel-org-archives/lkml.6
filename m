Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E51C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36896206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36896206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeIJHg7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:36:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:36766 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbeIJHg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:36:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2018 19:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,354,1531810800"; 
   d="scan'208";a="262093375"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2018 19:45:15 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 9 Sep 2018 19:45:15 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 9 Sep 2018 19:45:14 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Mon, 10 Sep 2018 10:45:13 +0800
From:   "Xu, Pinzhen" <pinzhen.xu@intel.com>
To:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Memory leak in dell-smbios-wmi.c
Thread-Topic: Memory leak in dell-smbios-wmi.c
Thread-Index: AdRIsEPpnVfZn1gkSpGOXsiT60g38Q==
Date:   Mon, 10 Sep 2018 02:45:12 +0000
Message-ID: <9B08B519B25F86498FA0D010F395E43DED0AD3@shsmsx102.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTJkYjU3MjEtOTY3Ni00OGZhLWJhMzktMzY5MDA4ZjI4ZWQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidmNkRDN0VnFkdXhCb0Q0dmtURmxMNVREejBlR2toem1FN1dNVkJuM1kyeHd4SkRWWnRIVmhIYnRLdWp0VFU3eCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There might be a possible memory leak in drivers/platform/x86/dell-smbios-wmi.c
In the `run_smbios_call' function, the buffer created via ACPI_ALLOCATE_BUFFER
within the output object is not freed properly.


Generally, this buffer should be freed using:
  kfree(output.pointer);


But it hasn't been cleaned up after a `memcpy' being done.
static int run_smbios_call(struct wmi_device *wdev)
{
      struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
      struct wmi_smbios_priv *priv;
      struct acpi_buffer input;
      union acpi_object *obj;
      acpi_status status;

      priv = dev_get_drvdata(&wdev->dev);
      input.length = priv->req_buf_size - sizeof(u64);
      input.pointer = &priv->buf->std;

      dev_dbg(&wdev->dev, "evaluating: %u/%u [%x,%x,%x,%x]\n",
            priv->buf->std.cmd_class, priv->buf->std.cmd_select,
            priv->buf->std.input[0], priv->buf->std.input[1],
            priv->buf->std.input[2], priv->buf->std.input[3]);

      status = wmidev_evaluate_method(wdev, 0, 1, &input, &output);
      if (ACPI_FAILURE(status))
            return -EIO;
      obj = (union acpi_object *)output.pointer;
      if (obj->type != ACPI_TYPE_BUFFER) {
            dev_dbg(&wdev->dev, "received type: %d\n", obj->type);
            if (obj->type == ACPI_TYPE_INTEGER)
                  dev_dbg(&wdev->dev, "SMBIOS call failed: %llu\n",
                        obj->integer.value);
            return -EIO;
      }
      memcpy(&priv->buf->std, obj->buffer.pointer, obj->buffer.length);
      dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
            priv->buf->std.output[0], priv->buf->std.output[1],
            priv->buf->std.output[2], priv->buf->std.output[3]);

      return 0;
}


Found with kmemleak:
unreferenced object 0xffff8f79382e0000 (size 8192):
  comm "fwupd", pid 3467, jiffies 4294967131 (age 265623.160s)
  hex dump (first 32 bytes):
    03 00 00 00 00 10 00 00 18 00 2e 38 79 8f ff ff  ...........8y...
    00 00 00 00 00 00 00 00 11 00 16 00 00 00 00 00  ................
  backtrace:
    [<0000000000d8a77d>] __kmalloc+0x14e/0x240
    [<00000000affbc59b>] acpi_os_allocate+0x27/0x29
    [<000000003fd4a388>] acpi_ut_initialize_buffer+0x3f/0x73
    [<0000000027ecea33>] acpi_evaluate_object+0x22b/0x3aa
    [<00000000e26b12ce>] wmidev_evaluate_method+0x114/0x150 [wmi]
    [<00000000ccecc6ff>] run_smbios_call+0x6d/0x190 [dell_smbios]
    [<00000000e8e58b51>] dell_smbios_wmi_filter+0x71/0xd0 [dell_smbios]
    [<00000000c3818758>] wmi_ioctl+0x100/0x232 [wmi]
    [<00000000cbfe4a18>] do_vfs_ioctl+0xa8/0x620
    [<0000000035f23e13>] ksys_ioctl+0x67/0x90
    [<00000000b3776114>] __x64_sys_ioctl+0x1a/0x20
    [<00000000477604b1>] do_syscall_64+0x5a/0x110
    [<00000000a6b58460>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<00000000fa4ff21e>] 0xffffffffffffffff
