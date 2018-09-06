Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD31C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F95206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F95206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeIFRsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:48:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIFRsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:48:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DCuFb304533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:12:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DCuhx304529;
        Thu, 6 Sep 2018 06:12:56 -0700
Date:   Thu, 6 Sep 2018 06:12:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0o770jvdcy04ee6vhv6v471m@git.kernel.org>
Cc:     wangnan0@huawei.com, adrian.hunter@intel.com, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        jolsa@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, dsahern@gmail.com,
          wangnan0@huawei.com, mingo@kernel.org, hpa@zytor.com,
          namhyung@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add a etcsnoop.c augmented syscalls
 eBPF utility
Git-Commit-ID: 9ab5aadebeddc77fccfdf94a048259315ce95fe1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9ab5aadebeddc77fccfdf94a048259315ce95fe1
Gitweb:     https://git.kernel.org/tip/9ab5aadebeddc77fccfdf94a048259315ce95fe1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 15:02:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Add a etcsnoop.c augmented syscalls eBPF utility

We need to put common stuff into a separate header in tools/perf/include/bpf/
for these augmented syscalls, but I couldn't resist adding a etcsnoop.c tool,
combining augmented syscalls + filtering, that in the future will be passed
from 'perf trace''s command line, to use in building the eBPF program to do
that specific filtering at the source, inside the kernel:

  Running system wide: (hope there isn't any embarassing stuff here...  ;-) )

  # perf trace -e tools/perf/examples/bpf/etcsnoop.c
       0.000 sed/21878 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
    1741.473 cat/21883 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
    1741.892 cat/21883 openat(dfd: CWD, filename: /etc/passwd)
    1748.948 sed/21886 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
    1777.136 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1777.738 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1778.158 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1778.528 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1778.595 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1778.901 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1778.939 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1778.966 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1778.992 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.019 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.045 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.071 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.095 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.121 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.148 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.175 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.202 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.229 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.254 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.279 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.309 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.336 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.363 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.388 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.414 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.442 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.470 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.500 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.529 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.557 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.586 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.617 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.648 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.679 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.706 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.739 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.769 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.798 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.823 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.844 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.862 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.880 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.911 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.942 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1779.972 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1780.004 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
    1780.035 gvfs-udisks2-v/2302 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
   13059.154 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13060.739 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13061.990 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13063.177 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13064.265 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13065.483 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13067.383 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13068.902 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13069.922 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13070.915 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13072.612 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13074.816 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13077.343 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13078.731 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13559.064 DNS Res~er #22/21054 open(filename: /etc/hosts, flags: CLOEXEC)
   22419.522 sed/21896 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   24473.313 git/21900 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   24491.988 less/21901 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   24493.793 git/21901 openat(dfd: CWD, filename: /etc/sysless)
   24565.772 sed/21924 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   25878.752 git/21928 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   26075.666 git/21928 open(filename: /etc/localtime, flags: CLOEXEC)
   26075.565 less/21929 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   26076.060 less/21929 openat(dfd: CWD, filename: /etc/sysless)
   26346.395 sed/21932 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   26483.583 sed/21938 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   26954.890 sed/21944 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   27016.165 gsd-color/1762 openat(dfd: CWD, filename: /etc/localtime)
   27016.414 gsd-color/1762 openat(dfd: CWD, filename: /etc/localtime)
   27712.313 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
   27712.616 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
   27829.035 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   27829.368 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   27829.584 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   27829.800 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   27830.107 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   27830.521 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   27961.516 git/21948 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   27987.568 less/21949 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   27988.948 bash/21949 openat(dfd: CWD, filename: /etc/sysless)
   28043.536 sed/21972 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   28736.008 sed/21978 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   34882.664 git/21991 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   34882.664 sort/21990 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   34884.441 uniq/21992 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   35593.098 git/21997 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   35638.839 git/21997 openat(dfd: CWD, filename: /etc/gitattributes)
   35702.851 sed/22000 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   36076.039 sed/22006 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   37569.049 git/22014 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   37673.712 git/22014 open(filename: /etc/localtime, flags: CLOEXEC)
   37781.710 vim/22040 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   37783.667 git/22040 openat(dfd: CWD, filename: /etc/vimrc)
   37792.394 git/22040 open(filename: /etc/nsswitch.conf, flags: CLOEXEC)
   37792.436 git/22040 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   37792.580 git/22040 open(filename: /etc/passwd, flags: CLOEXEC)
   43893.625 DNS Res~er #23/21365 open(filename: /etc/hosts, flags: CLOEXEC)
   48060.409 nm-dhcp-helper/22044 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48071.745 systemd/1 openat(dfd: CWD, filename: /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service, flags: CLOEXEC|NOFOLLOW|NOCTTY)
   48082.780 nm-dispatcher/22049 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48111.418 systemd/22049 open(filename: /etc/NetworkManager/dispatcher.d, flags: CLOEXEC|DIRECTORY|NONBLOCK)
   48111.904 systemd/22049 open(filename: /etc/localtime, flags: CLOEXEC)
   48118.357 00-netreport/22052 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48119.668 systemd/22052 open(filename: /etc/nsswitch.conf, flags: CLOEXEC)
   48119.762 systemd/22052 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48119.887 systemd/22052 open(filename: /etc/passwd, flags: CLOEXEC)
   48120.025 systemd/22052 openat(dfd: CWD, filename: /etc/NetworkManager/dispatcher.d/00-netreport)
   48124.144 hostname/22054 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48125.492 systemd/22052 openat(dfd: CWD, filename: /etc/init.d/functions)
   48127.253 systemd/22052 openat(dfd: CWD, filename: /etc/profile.d/lang.sh)
   48127.388 systemd/22052 openat(dfd: CWD, filename: /etc/locale.conf)
   48137.749 cat/22056 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48143.519 04-iscsi/22058 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48144.438 04-iscsi/22058 open(filename: /etc/nsswitch.conf, flags: CLOEXEC)
   48144.478 04-iscsi/22058 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48144.577 04-iscsi/22058 open(filename: /etc/passwd, flags: CLOEXEC)
   48144.819 04-iscsi/22058 openat(dfd: CWD, filename: /etc/NetworkManager/dispatcher.d/04-iscsi)
   48145.620 10-ifcfg-rh-ro/22059 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48146.169 systemd/22059 open(filename: /etc/nsswitch.conf, flags: CLOEXEC)
   48146.207 systemd/22059 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48146.287 systemd/22059 open(filename: /etc/passwd, flags: CLOEXEC)
   48146.387 systemd/22059 openat(dfd: CWD, filename: /etc/NetworkManager/dispatcher.d/10-ifcfg-rh-routes.sh)
   48147.215 11-dhclient/22060 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48147.787 11-dhclient/22060 open(filename: /etc/nsswitch.conf, flags: CLOEXEC)
   48147.813 11-dhclient/22060 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48147.929 11-dhclient/22060 open(filename: /etc/passwd, flags: CLOEXEC)
   48148.016 11-dhclient/22060 openat(dfd: CWD, filename: /etc/NetworkManager/dispatcher.d/11-dhclient)
   48148.906 grep/22063 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48151.165 11-dhclient/22060 openat(dfd: CWD, filename: /etc/sysconfig/network)
   48151.560 11-dhclient/22060 open(filename: /etc/dhcp/dhclient.d/, flags: CLOEXEC|DIRECTORY|NONBLOCK)
   48151.704 11-dhclient/22060 openat(dfd: CWD, filename: /etc/dhcp/dhclient.d/chrony.sh)
   48153.593 20-chrony/22065 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48154.695 20-chrony/22065 open(filename: /etc/nsswitch.conf, flags: CLOEXEC)
   48154.756 20-chrony/22065 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48154.914 20-chrony/22065 open(filename: /etc/passwd, flags: CLOEXEC)
   48155.067 20-chrony/22065 openat(dfd: CWD, filename: /etc/NetworkManager/dispatcher.d/20-chrony)
   48156.962 25-polipo/22066 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48157.824 systemd/22066 open(filename: /etc/nsswitch.conf, flags: CLOEXEC)
   48157.866 systemd/22066 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
   48157.981 systemd/22066 open(filename: /etc/passwd, flags: CLOEXEC)
   48158.090 systemd/22066 openat(dfd: CWD, filename: /etc/NetworkManager/dispatcher.d/25-polipo)
   48533.616 gsd-housekeepi/2412 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC)
   87122.021 gsd-color/1762 openat(dfd: CWD, filename: /etc/localtime)
   87122.146 gsd-color/1762 openat(dfd: CWD, filename: /etc/localtime)
   87825.582 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
   87825.844 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
   87829.524 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   87830.531 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   87831.288 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   87832.011 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   87832.672 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   87833.276 gnome-shell/2125 openat(dfd: CWD, filename: /etc/localtime)
   ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0o770jvdcy04ee6vhv6v471m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../bpf/{augmented_syscalls.c => etcsnoop.c}       | 31 +++++-----------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/etcsnoop.c
similarity index 79%
copy from tools/perf/examples/bpf/augmented_syscalls.c
copy to tools/perf/examples/bpf/etcsnoop.c
index a9695c7f7aab..b59e8812ee8c 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/etcsnoop.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Augment the openat syscall with the contents of the filename pointer argument.
+ * Augment the filename syscalls with the contents of the filename pointer argument
+ * filtering only those that do not start with /etc/.
  *
  * Test it with:
  *
@@ -30,21 +31,24 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
 struct augmented_filename {
 	int	size;
 	int	reserved;
-	char	value[256];
+	char	value[64];
 };
 
-#define augmented_filename_syscall_enter(syscall) 							\
+#define augmented_filename_syscall_enter(syscall) 						\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct augmented_filename		filename;				 	\
 };												\
 int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 {												\
+	char etc[6] = "/etc/";									\
 	struct augmented_enter_##syscall##_args augmented_args = { .filename.reserved = 0, }; 	\
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
 	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value, 		\
 						      sizeof(augmented_args.filename.value), 	\
 						      args->filename_ptr); 			\
+	if (__builtin_memcmp(augmented_args.filename.value, etc, 4) != 0)			\
+		return 0;									\
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
 			  &augmented_args, 							\
 			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
@@ -73,25 +77,4 @@ struct syscall_enter_open_args {
 
 augmented_filename_syscall_enter(open);
 
-struct syscall_enter_inotify_add_watch_args {
-	unsigned long long common_tp_fields;
-	long		   syscall_nr;
-	long		   fd;
-	char		   *filename_ptr;
-	long		   mask;
-};
-
-augmented_filename_syscall_enter(inotify_add_watch);
-
-struct statbuf;
-
-struct syscall_enter_newstat_args {
-	unsigned long long common_tp_fields;
-	long		   syscall_nr;
-	char		   *filename_ptr;
-	struct stat	   *statbuf;
-};
-
-augmented_filename_syscall_enter(newstat);
-
 license(GPL);
