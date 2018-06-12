Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5C5E0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C992208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C992208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbeFLFTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:19:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:41264 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753173AbeFLFT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:19:29 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C5JDa2008698;
        Tue, 12 Jun 2018 00:19:14 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 0/5] FSI scom driver overhaul 
Date:   Tue, 12 Jun 2018 15:19:06 +1000
Message-Id: <20180612051911.20690-1-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current FSI scom driver is a bit too simplistic (and buggy). This
fixes a locking bug, cleans a few things up, then overhaul the driver
more thoroughly by providing proper support for the different type
of SCOM accesses (direct and indirect), handling errors properly in
the read/write interface, and adding a lower level ioctl interface
needed by system debugger (such as cronus) that need to be able to
access the raw status register content resulting from the access
attempt and do their own error handling.

I will send patches separately for pdbg and cronus to use the new
debugger interface.

Note: It is unfortunate that the read/write interface does NOT use
the same addressing scheme as the host-side equivalent xscom debugfs
interface. However I didn't want to change the user ABI by "fixing"
this as I'm not entirely sure what other users we might have of
that existing interface.

The patches apply on top of the other FSI changes posted recently
and at this point are meant to discuss the new user API.


