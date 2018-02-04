Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeBDQ0S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 11:26:18 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:39364 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeBDQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 11:26:12 -0500
X-Google-Smtp-Source: AH8x226ZIh05vUfk0bEgN1btmlnay55L3DgrCeUb+QiQPzIcP+xRN8Ac7/nwPq+4N7SdZrnHDPRJAA==
Date: Sun, 4 Feb 2018 19:29:54 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Mario.Limonciello@dell.com, dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: PROBLEM: NULL pointer dereference in dell_set_arguments() in 4.15
Message-ID: <20180204162954.GA24841@localhost.localdomain>
References: <20180203162021.GA4571@localhost.localdomain>
 <e489f5ee-34e5-4777-afe7-38d31d2ad3fd@Dell.com>
 <20180204092333.GA2010@localhost.localdomain>
 <20180204121530.sl3h77mxbwusp2ul@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180204121530.sl3h77mxbwusp2ul@pali>
User-Agent: mtt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>To make dell_micmute_led_set() work properly we need to ensure that either WMI 
>or SMM driver is already loaded and initialized.

>From the looks of the call trace dell_micmute_led_set() is called from device 
phase of initialization. Which means that there is a use of dell-laptop 
interface while the module is not initialized (since late_initcall). 
Previously, this led to crashes.

But dell_micmute_led_set() does not touch the module state now, so nothing is 
technically broken; dell-smbios and dell-smbios-smm use subsys_initcall, so 
they are ready. But WMI driver is in the same phase with intel hda, so there 
might be something there.
