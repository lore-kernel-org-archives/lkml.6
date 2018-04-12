Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeDLQBZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:01:25 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36425 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:01:24 -0400
X-Google-Smtp-Source: AIpwx49uPWRzeZMhJUErMRl2jnfDIGHAA05WPK1qBcZ0EzRjuPfcpZkyL+ecCzissiDuq9VezSBzKA==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
X-Google-Original-From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com,
        iurii.konovalenko@globallogic.com,
        oleksandr.dmytryshyn@globallogic.com, konrad.wilk@oracle.com,
        tiwai@suse.de, andr2000@gmail.com
Subject: [PATCH 0/5] for-linux/sndif: add explicit back and front synchronization
Date: Thu, 12 Apr 2018 19:00:57 +0300
Message-Id: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all!

This is the syncup version of the sound protocol changes for
Linux Kernel with the only difference from the corresponding Xen
version being spaces to tabs conversion. Regradless of this only
change I have dropped R-b tags received for Xen version.

In order to provide explicit synchronization between backend and
frontend the following changes are introduced in the protocol:
 - bump protocol version to 2
 - add new ring buffer for sending asynchronous events from
   backend to frontend to report number of bytes played by the
   frontend (XENSND_EVT_CUR_POS)
 - introduce trigger events for playback control: start/stop/pause/resume
 - add "req-" prefix to event-channel and ring-ref to unify naming
   of the Xen event channels for requests and events
 - add XENSND_OP_HW_PARAM_QUERY request to read/update
   stream configuration space: request passes desired intervals/formats for
   the stream parameters and the response returns allowed intervals and
   formats mask that can be used.
 - MAJOR: changed req/resp/evt packet sizes from 32 to 64 octets
 -  Reworked XENSND_OP_HW_PARAM_QUERY so it now sends all
   parameters at once, allowing to check all the configuration
   space.
 - Minor documentation cleanup (added missed "reserved" fields)

Oleksandr Andrushchenko (5):
  xen/sndif: Introduce protocol version
  xen/sndif: Fix missed "reserved" fields in comments
  xen/sndif: Make requests and responses 64 octets long
  xen/sndif: Add explicit back and front synchronization
  xen/sndif: Add explicit back and front parameter negotiation

 include/xen/interface/io/sndif.h | 322 +++++++++++++++++++++++++++++--
 1 file changed, 306 insertions(+), 16 deletions(-)

-- 
2.17.0
