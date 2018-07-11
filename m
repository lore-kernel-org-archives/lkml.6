Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B35C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5C12087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/lFu90c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5C12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389662AbeGKT2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37105 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbeGKT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so20002335edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZG9VxHsFNKoF0JpBa3POjM5KPFX51KBxIgGzwNghdgE=;
        b=i/lFu90cx26VxOBF6NGX3Bhh+BM0ceT/hzEB4Kxj9RST7y2Sav+MrXUetGkS3trV04
         e6i/28iivG9L53CpR/dLQ3+fynSh14NeEIsqo/sNFa9+NYbS7IFP9p76fhWyd77n4pQT
         eP3gi/nfzfj2looKo9+/eO/gfDMT3aONLBOQApFcPwE4MCGvuMVrMih9VRDv0HI0dDox
         ukWfUR3co83uIY/pApvpw6nx6AA+sHL8M11fJSI2qyld7Yz32uQaX+XCKgwYUjashq/i
         O+HOTz1ZBL4pD87QKuThmpin73+SZlWWVU4EOPeoG40/2UeKyKrodELWf/g0z/Zl8QLo
         Igtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZG9VxHsFNKoF0JpBa3POjM5KPFX51KBxIgGzwNghdgE=;
        b=ZnvsXv2jSGVql25bBBW3waqMIHBsLeAkSoKBxvJ5VMHdUuiHL8/o/da3k4wy+L3eEI
         rND1FZMqbrzMkE0PIWC8pktF9iCvDwg3aUVf7TDp5IjyCDdlUlU9KJaCX8G4jqOLyiM9
         dcJoUVPz1t9/HqYYgyxCtcXoyT8m76ALesfDeNlw4QxH58bEHE/UPnkQstXv+qth7xRe
         quROji8v/gL0ORFb9f7VoegB67mZfXQij+nN/X62T26Nv6gAtMJmx7HYkesoSPO22+1T
         EZyYJm0JGd6TL84LGZySmifJJQPM1f6bWjXZlBOZ5YcPIiLQEGQxyiEfcyefhghxGpya
         29vw==
X-Gm-Message-State: APt69E2B4BupPFeAzKmzY/6N7aYIk3PnCzvwxPpEF4KzpVi9pbE5XSk+
        V5UmN/9E5hwm/FbvHfXgnhq4AsS1
X-Google-Smtp-Source: AAOMgpfQz/hi/5HWVM+vwMAOwN8eqM8MXAwI6UmTE87OG0J3uvGjLHQYrAKDXJE3Wre9dSA3G3DmJQ==
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr32701968edd.293.1531336942193;
        Wed, 11 Jul 2018 12:22:22 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:21 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Subject: [0/10] staging:rtl8192u: One significant change...
Date:   Wed, 11 Jul 2018 20:21:39 +0100
Message-Id: <20180711192149.21621-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 9 patches in this series are coding style changes, including a
number of patches to remove the "typedef" directive from a number of data
structure definitions. This clears the checkpatch warning about defining new
data types in the code.

The last patch in the series, however, changes the data type of a member
variable from a u8 to an enumerated type. Generally in C an enumerated type is
implemented by the compiler as an int, but can be changed by compiler
directives. Either way the member variable will most probably have its size
changed by this patch. I don't think that the structure is mapped to hardware
or physical memory location, but is allocated and populated in the
rtl8192_usb_probe() function in the file r8192U_core.c. Given that
allocation/population I don't think that the size of the member variable is of
run time significance, bar the slight increase in size of the overall
structure.

The reason for doing this is to enable the compiler's checking of assignments
to the variable defined as an enumerated type. The alternative is to leave the
variable as a u8 and remove the enumerated type, replacing it with #define
definitions of the possible values.

I raised this issue on the kernel newbies mailing list and of the two
alternatives enumerated type won out.


