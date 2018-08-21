Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C24C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C72214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsfSwNC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C72214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHUVpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:45:43 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:42762 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHUVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:45:43 -0400
Received: by mail-pg1-f172.google.com with SMTP id y4-v6so8823849pgp.9;
        Tue, 21 Aug 2018 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WvqG4Q20y18uh+Z9oirQUqXN1LpIVKvF9zwefmdYxig=;
        b=HsfSwNC57yTlHvpjv8uHVNdr3QiOex/I8PSuA4M+nQSmz6swWwUgkCk8c4JaU2vItp
         iNQYgvP0VoriBMwCDqLtI866GON+eaLjZC45W/T42BCmhRBSDGaUCb7WwnOvBIRWCxX0
         dbKW+G8oFimvL8KSQ+qUw23dGb51lI3rwNwwRt7762Dd6aJ8KWOPrVcmB9FXx81O3M72
         gQ/mhAEjuHqQfAqjuo0nVV3yaAWFk/xM/1l/Rslq5Yq/rMBSeBTmSBNbODvA+5YJ0Q8F
         QT4mQKZEv356KiDM+WyGjWjWWKRs0Zqf/r0OlLHtlQl3Es4d5hweKfXGssshBi+sgF27
         CVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WvqG4Q20y18uh+Z9oirQUqXN1LpIVKvF9zwefmdYxig=;
        b=YMHQmE91WjR+2Um4hSylvD8RhOWS7gIyIsxrTUthk6Q/jqR45mlIWtQz9/i2W0+KPG
         vPlimFv1zmv9tWsZ4FNDpGRPZno7a06/VAqQafVT3XJjDT4/XQ7kDL2crp+YKpXaP45z
         eFZi/8FesXFdlP8jHffsIUZ8NFUiY0PRgG4QdBpUwgdmJfeN0WpIHmaiEXdxqPm0yfzt
         geCQTtTiuhkFyfhD7BXDhk/AgAjn5QOqrOyw1JZFLZNcAOO4m2BRzK0uJ3VrWWKtEjNh
         bRbY0JrkKtyyS25uf7Zko8frsUrbzJpZ6+Fh0164cjRhVhF0uiCUgPgXoOZVtI3Ay0JO
         5MBA==
X-Gm-Message-State: AOUpUlHGJgxp+7u46Q/ydhVxcHIALg5bu+RFaHC4XkQv8eCCj3/7ERLF
        TFCcfSTO+dAXsnhESp7tYrYogpi7rWtV0A8W34qi1g==
X-Google-Smtp-Source: AA+uWPztz+kZ/Fsc7caU8EA69xRjOaq+5H8M/ZmFJB05wCiN4gzH/eyGjVvLF+V+iLzhVNmZh4y6knSMH9aKwS2zWRA=
X-Received: by 2002:a63:9412:: with SMTP id m18-v6mr10825474pge.440.1534875868891;
 Tue, 21 Aug 2018 11:24:28 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 21 Aug 2018 13:24:17 -0500
Message-ID: <CAH2r5mtO6545itRxAV0KW7NSt7ucvxgHOtg8wUZZ0DMHO-V8XQ@mail.gmail.com>
Subject: Overview of performance improvements of recent SMB3 compounding patches
To:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In experiments today with Ronnie's most recent compounding patches I
see the expected significant improvements in create/mkdir/unlink/rmdir
operations over SMB3 mounts (tests were to Samba but would be similar
to all modern servers).  See below:

"touch /mnt/file"  goes from 6 request/response pairs to 4 with
Ronnie's compounding patches
"rm /mnt/file" from 5 to 2 request/response pairs
"mkdir /mnt/newdir" 6 pairs to 3 pairs
"rmdir /mnt/newdir" 6 pairs down to 2 pairs

Good job Ronnie!
-- 
Thanks,

Steve
