Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeCWLvm convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754222AbeCWLvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:51:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EAB2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AG47ELuxX6jkPkMP7Q6c0D95soAhf7cdqo0jdHBiClApGYJSNQYDEBidsbl7u4ik3PFlyOLXBD+0h6M6MUxw6ni5tBE=
MIME-Version: 1.0
In-Reply-To: <20180322115338.54a9b68c@canb.auug.org.au>
References: <20180322115338.54a9b68c@canb.auug.org.au>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 23 Mar 2018 12:51:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd8EWQtL+himAFXWmkVMttwK0uvSkbT5DSJcnRMyVk7jw@mail.gmail.com>
Message-ID: <CAJKOXPd8EWQtL+himAFXWmkVMttwK0uvSkbT5DSJcnRMyVk7jw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the mac80211 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Caradoc-Davies <ben@transient.nz>, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Mar 22, 2018 at 1:53 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   net/mac80211/debugfs.c
>   include/net/mac80211.h
>
> between commit:
>
>   7c181f4fcdc6 ("mac80211: add ieee80211_hw flag for QoS NDP support")
>
> from the mac80211 tree and commit:
>
>   94ba92713f83 ("mac80211: Call mgd_prep_tx before transmitting deauthentication")
>
> from the net-next tree.

Hi everyone,

Since next-20180322 one of my boards fails to boot from NFS root.
Bisect pointed me to the:
397ae02005e4fea0f277d9da20b91c5bb70cdb81 ("Merge remote-tracking
branch 'net-next/master'")

Board is an Odroid XU (ARM, Exynos5410, big.LITTLE but only 4x
Cortext-A15 are working) running Arch Arm Linux and systemd 236.81-1
(not updated for some time so it could be that the specific SW version
is needed to trigger the issue, not the HW).
Root is from NFSv4 from Raspberry Pi.

System fails to start the job Flush Journal to Persistent Storage:
Mar 23 09:22:49 [* ] A start job is running for Flush Jo…Persistent Storage
...
Mar 23 09:25:37 [ 215.530704] nfs: server 192.168.1.10 not responding,
still trying

Full kernel logs are here:
http://www.krzk.eu/#/builders/22/builds/271/steps/10/logs/serial0


Full bisect log:
# bad: [397ae02005e4fea0f277d9da20b91c5bb70cdb81] Merge
remote-tracking branch 'net-next/master'
# good: [c698ca5278934c0ae32297a8725ced2e27585d7f] Linux 4.16-rc6
# good: [cd126c45999931c00f5f733f41d750a69cd73dfa] nfs4: always reset
notified flag to false before repolling for lock
# good: [5f2fb802eee1df0810b47ea251942fe3fd36589a] ipv6: old_dport
should be a __be16 in __ip6_datagram_connect()
# good: [8b229cb16695e58482347339da523b87a8087596] Merge branch
'clk-hisi' into clk-next
# good: [5f1dd1796c7c58214aa0bff37730d5984b292bec] Merge branch
'v4.17/drivers' into tmp/aml-rebuild
# good: [aacbc447c42b747bfbc096993723cc73314c9696] NFS: Fix unstable
write completion
# good: [78262f4575c29f185947fe58952cd1beabc74f82] bpf, doc: add
description wrt native/bpf clang target and pointer size
# good: [cd126c45999931c00f5f733f41d750a69cd73dfa] nfs4: always reset
notified flag to false before repolling for lock
# good: [55108726af7402f306fb0b67652c040502d376f6] Add linux-next
specific files for 20180321
# good: [27f00231589292d59443558da7ea64ed8a48723e] nfs4: wake any lock
waiters on successful RECLAIM_COMPLETE
# good: [dbc0f1b844eef96f1e9c9fbf2c8f18ca49c683b9] Merge
remote-tracking branch 'vfs/for-next'
# good: [0466080c751ec2de9efae3ac6305225cc4326047] Merge branch
'dsa-mv88e6xxx-some-fixes'
# good: [0f1a0183eae6bbb0527af322224cb930a7b38805] Merge branches
'thermal-core' and 'thermal-soc' into next
# good: [94dee79363a351985124b27347e2d53e1a6b0183] Merge branches
'pm-cpuidle', 'powercap' and 'pm-tools' into linux-next
# good: [185899ee8d00460a305e07ed2df178dbf7455227] IB/uverbs: Enable
ioctl() uAPI by default for new verbs
# good: [dc07174fd3d89b3ef518a9c993023d29dd59d804] Merge branch
'i2c/for-4.17' into i2c/for-next
# good: [72816cb06e7153c22aed8776949f558b635aa2c0] hwmon: (ucd9000)
Add debugfs attributes to provide mfr_status
# good: [58eb5b6707477ff458db3ee522aac317da719e2a] pstore: fix crypto
dependencies
# good: [3d172f44ffab8d9f8496f672787ad2ed3f251b46] Merge branch
'for-4.17' into for-next
# good: [eb693e35e850d915fae2c63dc5cef6751b466fa6] firmware: dmi_scan:
add DMI_OEM_STRING support to dmi_matches
# good: [2c81ee0a28c085582a84f3822e8a22e028a909d0] video: fbdev: via:
remove VLA usage
# good: [3f127ce11353fd1071cae9b65bc13add6aec6b90] media:
em28xx-cards: fix em28xx_duplicate_dev()
# good: [6234c7bd8c14508fb76c0a4d6f01eb81c8ce9cbf] docs: ftrace: fix a
few formatting issues
# good: [454bfe97837a3e3a5a15b768f8293f228e0f2f06] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect start '397ae02005e4fea0f277d9da20b91c5bb70cdb81'
'v4.16-rc6' 'cd126c45999931c00f5f733f41d750a69cd73dfa'
'5f2fb802eee1df0810b47ea251942fe3fd36589a'
'8b229cb16695e58482347339da523b87a8087596'
'5f1dd1796c7c58214aa0bff37730d5984b292bec'
'aacbc447c42b747bfbc096993723cc73314c9696'
'78262f4575c29f185947fe58952cd1beabc74f82'
'cd126c45999931c00f5f733f41d750a69cd73dfa'
'55108726af7402f306fb0b67652c040502d376f6'
'27f00231589292d59443558da7ea64ed8a48723e'
'dbc0f1b844eef96f1e9c9fbf2c8f18ca49c683b9'
'0466080c751ec2de9efae3ac6305225cc4326047'
'0f1a0183eae6bbb0527af322224cb930a7b38805'
'94dee79363a351985124b27347e2d53e1a6b0183'
'185899ee8d00460a305e07ed2df178dbf7455227'
'dc07174fd3d89b3ef518a9c993023d29dd59d804'
'72816cb06e7153c22aed8776949f558b635aa2c0'
'58eb5b6707477ff458db3ee522aac317da719e2a'
'3d172f44ffab8d9f8496f672787ad2ed3f251b46'
'eb693e35e850d915fae2c63dc5cef6751b466fa6'
'2c81ee0a28c085582a84f3822e8a22e028a909d0'
'3f127ce11353fd1071cae9b65bc13add6aec6b90'
'6234c7bd8c14508fb76c0a4d6f01eb81c8ce9cbf'
'454bfe97837a3e3a5a15b768f8293f228e0f2f06'
# good: [62684a8e3f1a85daccd129ac7dd995d15499acce] Merge
remote-tracking branch 'rdma/for-next'
git bisect good 62684a8e3f1a85daccd129ac7dd995d15499acce
# first bad commit: [397ae02005e4fea0f277d9da20b91c5bb70cdb81] Merge
remote-tracking branch 'net-next/master'

Let me know if I can help with some more details or testing.

Best regards,
Krzysztof
