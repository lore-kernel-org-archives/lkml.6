Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeCUWPI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:15:08 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38844 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbeCUWPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:15:03 -0400
X-Google-Smtp-Source: AG47ELv6YtQO9W2K8sRo6C5Dr5by7M1fOn4ixRUhHiwLf/aXdhk/rib+yQM1R1I/Clo3JFaucV+Hq79SgTwCc1hGR9I=
MIME-Version: 1.0
In-Reply-To: <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan>
 <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com> <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Mar 2018 23:15:01 +0100
X-Google-Sender-Auth: SThFWxlApilA4ju_xd7Wh0w7XuY
Message-ID: <CAJZ5v0iThFDEjnwTbpAhwHY_vF_KDdAUyhDL1CdB4GJsG5eNRQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c6f8890567f3852b"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c6f8890567f3852b
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 21, 2018 at 6:59 PM, Thomas Ilsche
<thomas.ilsche@tu-dresden.de> wrote:
> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
>>
>>
>> So please disregard this one entirely and take the v7.2 replacement
>> instead of it:https://patchwork.kernel.org/patch/10299429/
>>
>> The current versions (including the above) is in the git branch at
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>   idle-loop-v7.2
>
>
> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
> as with v5: several cores which just keep the sched tick enabled.
> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
> full sched tick.
> The resulting power consumption is ~105 W instead of ~ 70 W.
>
> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
>
> I have briefly ran v7 and I believe it was also affected.

Then it looks like menu_select() stubbornly thinks that the idle
duration will be within the tick boundary on those cores.

That may be because the bumping up of the correction factor in
menu_reflect() is too conservative or it may be necessary to do
something radical to measured_us in menu_update() in case of a tick
wakeup combined with a large next_timer_us value.

For starters, please see if the attached patch (on top of the
idle-loop-v7.2 git branch) changes this behavior in any way.

--000000000000c6f8890567f3852b
Content-Type: text/x-patch; charset="US-ASCII"; name="cpuidle-menu-menu_reflect-debug.patch"
Content-Disposition: attachment;
	filename="cpuidle-menu-menu_reflect-debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jf1n9a0y0

LS0tCiBkcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL21lbnUuYyB8ICAgIDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKSW5kZXg6IGxpbnV4LXBtL2Ry
aXZlcnMvY3B1aWRsZS9nb3Zlcm5vcnMvbWVudS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9y
aWcvZHJpdmVycy9jcHVpZGxlL2dvdmVybm9ycy9tZW51LmMKKysrIGxpbnV4LXBtL2RyaXZlcnMv
Y3B1aWRsZS9nb3Zlcm5vcnMvbWVudS5jCkBAIC00OTgsNyArNDk4LDcgQEAgc3RhdGljIHZvaWQg
bWVudV9yZWZsZWN0KHN0cnVjdCBjcHVpZGxlXwogCQkgKiBjb3JyZWN0aW9uIGZhY3Rvci4gIFVz
ZSAwLjc1ICogUkVTT0xVVElPTiAod2hpY2ggaXMgZWFzeQogCQkgKiBlbm91Z2ggdG8gZ2V0KSB0
aGF0IHNob3VsZCB3b3JrIGZpbmUgb24gdGhlIGF2ZXJhZ2UuCiAJCSAqLwotCQluZXdfZmFjdG9y
ICs9IFJFU09MVVRJT04gLyAyICsgUkVTT0xVVElPTiAvIDQ7CisJCW5ld19mYWN0b3IgKz0gUkVT
T0xVVElPTjsKIAkJZGF0YS0+Y29ycmVjdGlvbl9mYWN0b3JbZGF0YS0+YnVja2V0XSA9IG5ld19m
YWN0b3I7CiAJfSBlbHNlIHsKIAkJZGF0YS0+bmVlZHNfdXBkYXRlID0gMTsK
--000000000000c6f8890567f3852b--
