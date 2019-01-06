Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11379C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C795820830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJPnfS6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAFV1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 16:27:13 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33242 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfAFV1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 16:27:13 -0500
Received: by mail-lf1-f47.google.com with SMTP id i26so28813912lfc.0;
        Sun, 06 Jan 2019 13:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZzqdjFa8aYURTZPXyjuQm640nZgTSUnwQqvZBY0KP1k=;
        b=uJPnfS6zJRnBHORLz4KcJ4rG8faZEZSABT4VOQOa+K+pmwJPv0kKknqnl2KxthiSm0
         nvDJLiVy8b4jqfHJrAIKQWbadpl9ZcZdJjUDOjmC9knjsK2Ug+3ZQn+7fwXWnsN/Bjsh
         Q9m121fiuI885FcgvsF75uINGEMVTR/F4GM6M68JXMa1XGmECuTZPaULIkpJX3jKEdN6
         /Z9iLrfQlcsqxynxKjCmhQXPbOsnmBvOKy6rR2TPYAlOBTYfK/tMHvvFXwRT6qtpj18W
         WZBLf8YaHzHD6o+myfgEgXc+hXHFPGCMoHuJNR/dIH46rN+bQJ2AlSvhksLkcqj3VSdt
         7bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZzqdjFa8aYURTZPXyjuQm640nZgTSUnwQqvZBY0KP1k=;
        b=U655vEtk4lw6g3rtz1X08rDvbGePHvoGjm9yVtwVMgQg0kyH9whhBbPDWIaADPtPLw
         JyLazf1oM63hwwIakwDbmhJ2nA1wPI7LrqpW6Db/dWsXGNqJyXLBY3z4tZm5KWLyt0N3
         FRgS2skynR6LX9X4mIM+2fVk3JAKiVgIsCsM+7wOKlR2lMLr7m40go/XcokojNdB1UTc
         85Nog5TsxkMR+H/NeeP29dsVCAkg++YJqKNXEc3V7v4w64IOLONGxR6V4JUQDHE38U/A
         5uq0I1VXvcFJBL7KeatkJBKuQLmv6rGrDr9XXODPu+V9UM/ru4IysVTVeXXomfJsSZd6
         BTyA==
X-Gm-Message-State: AJcUukd7tL0IsboHmUrH66B5wrbfhH5yL9pd8iAuYIThuDKWQDpvI4AF
        K5WxPgScP7LfW/ObILJMNNmz3Xsj5GwaaEUmCY7elZ1X
X-Google-Smtp-Source: ALg8bN4+RUeVc9qbeKIeqbQT5rvmBSpAmTUJ7reSHVtXTabc1eJu2BE2EABdW3tqRD/4ZDBtZgIFB8ErTjwQEBj1KyE=
X-Received: by 2002:ac2:4215:: with SMTP id y21mr10240367lfh.6.1546810030642;
 Sun, 06 Jan 2019 13:27:10 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 6 Jan 2019 22:26:59 +0100
Message-ID: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
Subject: [BUG] v4.20 - bridge not getting DHCP responses? (works in 4.19.13)
To:     linux-netdev@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Switching from 4.19.x -> 4.20 resulted in DHCP not working for my VM:s.

My firewall (which also runs the dhcpd) runs VM:s and it does this by
having physical
interfaces attached to bridges - which the VM:s in turn attach to.

Since 4.20 the VM:s can't use DHCP, it's odd since the requests are
seen - a response is sent but
it never enters the interface attached to the bridge.

Basically:
VM vnet2: -> br0 -> eno2 -> switch -> eno1 (dhcpd)
dhcpd eno1 -> siwtch and... gone.

Any clues?

All the nics are handled by ixgbe
