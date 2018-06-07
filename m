Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IXTCB00aGVtVYgAAmS7hNA
	; Thu, 07 Jun 2018 11:43:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E0077608B8; Thu,  7 Jun 2018 11:43:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6BEE960452;
	Thu,  7 Jun 2018 11:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BEE960452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeFGLn4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:43:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54705 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeFGLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:43:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so17253064wmf.4;
        Thu, 07 Jun 2018 04:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CIpA4Fplk4if9Yl5ig6BWPA4vZHtpE5zKAfjT9EqPqw=;
        b=IBgqber+9lz0GryVnwyU6xxPTnPLZ+mVAeUIBWm8PNVL3qJgOZay7kJUpAU3Aw1rU7
         E4hNtRH/TzJZMqc4gCEgfxVfTE25kNHzh4IfJYfbw0ewScQ5HHLk/TFVJRdqorkcuWx+
         P9nhWd+dcZhvxhU5thf7bSdXiOPyQ1voFBJk50w+0Q/nN7wCJUUEwqrN/WvWf5mDUwYt
         y+GqRPSJJA92NSz/xzNRtWtdRUcwJ+dQBJUjnpq9z2tBtJu54cZ2OoPrw+ZUZX0xgipS
         Yb0RE3IJcnvcpl4xeJylWdH0txIuOOvf0aYznx5ONATyTbS3O3OjKz76n6NIIcmHpnDf
         Dy+g==
X-Gm-Message-State: APt69E1uR5etghVmXqgqrjgSUqp2qTM/DfqJAW7ZUdFyu5OAXQpOQRPb
        9HmnlKJYu5OADD8kV4pIQoLxuSXe
X-Google-Smtp-Source: ADUXVKKKEGEsWHWX1fMy/0QGxzW3WhIAMMMFWcE5CQWgLEcKlfH02BlagWQHY8gYJfbku3Hu1AqxKg==
X-Received: by 2002:a1c:88c9:: with SMTP id k192-v6mr1475725wmd.125.1528371832760;
        Thu, 07 Jun 2018 04:43:52 -0700 (PDT)
Received: from localhost.localdomain (u-086-c129.eap.uni-tuebingen.de. [134.2.86.129])
        by smtp.gmail.com with ESMTPSA id v13-v6sm15269280wrq.43.2018.06.07.04.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 04:43:51 -0700 (PDT)
From: Christian Brauner <christian@brauner.io>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: cjwatson@ubuntu.com, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk, serge@hallyn.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/1] getxattr: use correct xattr length
Date: Thu,  7 Jun 2018 13:43:47 +0200
Message-Id: <20180607114348.23667-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

When running in a container with a user namespace, if you call getxattr
with name = "system.posix_acl_access" and size % 8 != 4, then getxattr
silently skips the user namespace fixup that it normally does resulting in
un-fixed-up data being returned.
I think that the analysis that this is caused by
posix_acl_fix_xattr_to_user() being passed the total buffer size and not
the actual size of the xattr as returned by vfs_getxattr() is correct.
So this commit passes the actual length of the xattr as returned by
vfs_getxattr() down.

It might be worth considering making posix_acl_fix_xattr_userns() and
posix_acl_fix_xattr_to_user() return errors. Such that e.g.
posix_acl_xattr_count() errors can be caught in getxattr(). If that's
something we want I can send a follow-up patch.

More details of this can be found in
https://bugzilla.kernel.org/show_bug.cgi?id=199945

Thanks!
Christian

Christian Brauner (1):
  getxattr: use correct xattr length

 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.0
