Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4753C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4753C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeGTUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:01:42 -0400
Received: from smtp.infotech.no ([82.134.31.41]:38321 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388096AbeGTUBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:01:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2852D2041B2;
        Fri, 20 Jul 2018 21:12:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QUcLb6X5i+LR; Fri, 20 Jul 2018 21:11:55 +0200 (CEST)
Received: from [192.168.0.168] (CPEa84e3fcc6793-CMa84e3fcc6790.cpe.net.cable.rogers.com [99.242.181.9])
        by smtp.infotech.no (Postfix) with ESMTPA id D025720414E;
        Fri, 20 Jul 2018 21:11:52 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: [ANNOUNCE] lsscsi version 0.30 released
Reply-To: dgilbert@interlog.com
To:     SCSI development list <linux-scsi@vger.kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        David Sommerseth <davids@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <4ef33405-fc6d-f046-8a5e-a565e122b92d@interlog.com>
Date:   Fri, 20 Jul 2018 15:11:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lsscsi is a command line utility that probes sysfs in Linux 2.6, 3
and 4 series kernels in order to list information about SCSI
devices and SCSI hosts. The default format is one device (e.g. disk)
per line. Other storage devices that use the SCSI subsystem such as
SATA disks and USB keys are also listed.

Version 0.30 adds listing of NVMe devices following SCSI devices.
NVMe namespaces (e.g. /dev/nvme0n1) are listed with SCSI devices
(LUs) and have tuples that start with 'N' (e.g. "[N:0:1:1]"). NVMe
controllers (e.g. /dev/nvme0) are listed with SCSI hosts
(initiators).

lsblk differences:
   - lsblk lists disk partitions; lsscsi does not
   - lsblk lists storage devices that don't use the SCSI and NVMe
     subsystems; lsscsi does not. Example: non-USB connected
     SD cards with device names like /dev/mmcblk0...
   - lsscsi lists SCSI hosts (initiators) and NVMe controllers;
     lsblk does not
   - lsscsi lists pass-through devices (e.g. /dev/nvme0) which are
     typically character devices; lsblk does not
   - lsscsi lists meta storage devices such as tape robots and disk
     enclosures

Version 0.30 is available at:
     http://sg.danny.cz/scsi/lsscsi.html
More information can be found on that page including examples
plus a Download and Build information section containing
tarballs, rpm and deb packages.

ChangeLog:
Version 0.30 2018/06/12 [svn: r154]
   - add support for NVMe devices and controllers
     - to build without: ./configure --disable-nvme-supp
     - deselect at runtime: lsscsi --no-nvme
     - deselect SCSI devices at runtime: lsscsi N
   - add --brief for tuple + device_name(s) only
   - add --pdt (-D) for device type in hex
   - extend --size (-s) so when given three times
     the size as a logical block count is output
   - add --sz-lbs (-S) that is equivalent to '-sss'
     when used twice adds comma then logical block size
   - '-w' now decodes 128 bit WWN without truncation
   - /dev/disk/by-id/wwn- is not guaranteed to be
     persistent (or stable); instead use
     /dev/disk/by-id/scsi-
   - '-t' on a FC host was not printing the comma
     separator resulting in garbled output, fix
   - debian: bump compat file contents from 7 to 10

Version 0.29 2016/05/14 [svn: r137]
   - '-u' now decodes locally assigned UUIDs (spc5r08)
   - as last try use T10 Vendor ID for lu name
   - if no lu name found, print 'none'
   - change '-uuu' to output the full lu name followed
     by the normal fields (which were skipped before)
   - add 'U' option, same action as '-uuu'
   - '-UU' prefixes lu names with 'eui.', 'naa.', etc
   - if '-s' given twice, lu size is base 2 related
   - if very long [h:c:t:l] then append space
   - print_enclosure_device() for FCP may be useless,
     comment out while checking ...
   - with '-t' print 0x0000000000000000 for non-SAS
     device in SAS domain
   - autogen.sh: upgrade to 20091223 version
   - automake: upgrade to 1.15 (ubuntu 16.04)

Version 0.28 2014/09/30 [svn: r120]
...

Examples:
$ lsscsi -gs
[0:0:0:0]  disk Linux    scsi_debug       0188  /dev/sda   /dev/sg0    419MB
[0:0:0:1]  disk Linux    scsi_debug       0188  /dev/sdb   /dev/sg1    419MB
[N:0:1:1]  disk INTEL SSDPEKKF256G7L__1                    /dev/nvme0n1   256GB

$ lsscsi -H
[0]    scsi_debug
[N:0]  /dev/nvme0  INTEL SSDPEKKF256G7L           BTPY00000AU6256D    123P

Douglas Gilbert
