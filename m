Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226KoPUBCxLDazF4aE1GT10Rfvl5Qy0zM78YEao+5CLyYfWSptUzeUusba/R9splmRFH7jCG
ARC-Seal: i=1; a=rsa-sha256; t=1518709505; cv=none;
        d=google.com; s=arc-20160816;
        b=FNR+DX7RGQ3kQ3CDMyPIlQo8ztYQrKCfusunTPFAvr0DPmG72kU6y82by375Y7nqXi
         rEF7vIK3l7i7QRS4kFvfzDRpsS9JANKCF45kZQMCa3FITrG5nEucJ9I0AP+XrOBBZirM
         nUPPlJlwxToHC7torE2ZsaGI+SPtstfVUALTqnLnd4r7l2WzcRMG5FGyo3hjwhMo+/hR
         ZDX08ucns0V25VEk/uybMKdH/JtW9UjXgXHwZ5PSyICAwUO2572oAB2MeLleAjEuGC54
         8SKdn5S+ago482+YSulR8cpbNwD1vk/6fSFEOdSgedlHuFH1G2lVPMaW55ZoTUpFKPh/
         MMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VKt0Er5L2thT4qN2bIuEG2RxthSbZeNsydfKYNed9VI=;
        b=jQCG3Ha89REgftz30G2R8piakg1DMYQ66s9B6zJaByEB0E84NhLafiksrUyXdL1vPW
         TOu+eaiLvBIjKP+wWBkjd+FgrZTPZvv+0sgQ4MoMW3Jbtc95GJ9G5uKEOmQFQBtx4wxu
         J+Fi/DFanh+aegr933YvYMB9beTmIAezPeP8XCUcPm30dcxL+qGeIWzsrZjoyNsCPqmP
         Qps9CgeYemojtlsonowrn1XRhz+kvR3tA69BMPBEyXfXgnteY7t6MwHYeWMHJhB99oit
         J3gfGMslvMd3EkColeBjQN8rz+TCttuDunU2b6TaAb9IB2Hkqzz2p5EGZfPyBGQ7HjQi
         SnnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 4.15 142/202] afs: Add missing afs_put_cell()
Date: Thu, 15 Feb 2018 16:17:22 +0100
Message-Id: <20180215151720.494934181@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592482338994164880?=
X-GMAIL-MSGID: =?utf-8?q?1592482338994164880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit e44150157f42219fa5c074588efdb31ccfb197fc upstream.

afs_alloc_volume() needs to release the cell ref it obtained in the case of
an error.  Fix this by adding an afs_put_cell() call into the error path.

This can triggered when a lookup for a cell in a dynamic root or an
autocell mount returns an error whilst trying to look up the server (such
as ENOMEDIUM).  This results in an assertion failure oops when the module
is unloaded due to outstanding refs on a cell record.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/volume.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -102,6 +102,7 @@ static struct afs_volume *afs_alloc_volu
 error_2:
 	afs_put_serverlist(params->net, slist);
 error_1:
+	afs_put_cell(params->net, volume->cell);
 	kfree(volume);
 error_0:
 	return ERR_PTR(ret);
