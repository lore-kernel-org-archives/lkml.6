Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuP3wv6eurxSrJZdwOwvOPJOlmdQbfejErWm19w2m0qLjJ27NeVgyK36aB7lCtJvpKZ6oLv
ARC-Seal: i=1; a=rsa-sha256; t=1521484284; cv=none;
        d=google.com; s=arc-20160816;
        b=Pe7bPQIEGAgtP1UAcs4t2XTMsFX94tmyex2UXsNH9+0VvlLpO53owI58e3EqKA83AL
         CmqX0Q7xpXc0zvaFzSQvzG8xyEfzuOBUASmNkD/A5COWHqQKCdPF/qg7JGAdqaHFYVGs
         gm8Bn50ZYdod5JpQR8jkOHjtF9iRVO2viJlg0WbS3B0xPlTOlJbkZiQnV76bVWibsXsb
         v6Sy/y/fHDgP0wNEpEO8v70ClMnrCYCRkFHO7xgMJfNg/pJqn5moeMIwCJOy2cqDrBfR
         eKtk0lVFoB9AnNIGUlN84auNCDXa/DJzqCNv417PSSHZFKKEBoqayVs0L5gs3dZXz0fV
         7pVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w+uFfTSZyJxTHcDLyDKptn9AQU8ua98p+2Rrmn9mGbk=;
        b=ax75SCMVFVIufz9N/k6SXlDT1/4FczoiKkyXV7oywVc9E5ubsDlTOZzRwNROOZZrOB
         yc6uAJtOUMFCDKq50++kavhXNdZH4Yv20T0bHVSdVgbIDou5FA8n5g+hikao6F7PEedw
         L2OQoQW4/ZM/3/KpzCotvenVonQwlyNX3DwxZvNk39UqW6Jdr4zFkdmwHsJ9p4N8UQN5
         0TFSyOpGtNGy5o0xBSSkXUWqHt8I2fHQMQVfM97aOiRCNLh0l21oZN6KBVcaNIczjiVz
         0DxwQDmvD/D5slYeCpZbnpKCS0rrCFypmh0MmBbNO3yA4HgkZD7yTG95o+C5I1S6EYSI
         xRig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pierre Moreau <pierre.morrow@free.fr>,
	Lukas Wunner <lukas@wunner.de>,
	Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.15 15/52] drm/nouveau/bl: Fix oops on driver unbind
Date: Mon, 19 Mar 2018 19:08:13 +0100
Message-Id: <20180319180736.000818984@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391788434756898?=
X-GMAIL-MSGID: =?utf-8?q?1595391904617812830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 76f2e2bc627f7d08360ac731b6277d744d4eb599 upstream.

Unbinding nouveau on a dual GPU MacBook Pro oopses because we iterate
over the bl_connectors list in nouveau_backlight_exit() but skipped
initializing it in nouveau_backlight_init().  Stacktrace for posterity:

    BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
    IP: nouveau_backlight_exit+0x2b/0x70 [nouveau]
    nouveau_display_destroy+0x29/0x80 [nouveau]
    nouveau_drm_unload+0x65/0xe0 [nouveau]
    drm_dev_unregister+0x3c/0xe0 [drm]
    drm_put_dev+0x2e/0x60 [drm]
    nouveau_drm_device_remove+0x47/0x70 [nouveau]
    pci_device_remove+0x36/0xb0
    device_release_driver_internal+0x157/0x220
    driver_detach+0x39/0x70
    bus_remove_driver+0x51/0xd0
    pci_unregister_driver+0x2a/0xa0
    nouveau_drm_exit+0x15/0xfb0 [nouveau]
    SyS_delete_module+0x18c/0x290
    system_call_fast_compare_end+0xc/0x6f

Fixes: b53ac1ee12a3 ("drm/nouveau/bl: Do not register interface if Apple GMUX detected")
Cc: stable@vger.kernel.org # v4.10+
Cc: Pierre Moreau <pierre.morrow@free.fr>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_backlight.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -268,13 +268,13 @@ nouveau_backlight_init(struct drm_device
 	struct nvif_device *device = &drm->client.device;
 	struct drm_connector *connector;
 
+	INIT_LIST_HEAD(&drm->bl_connectors);
+
 	if (apple_gmux_present()) {
 		NV_INFO(drm, "Apple GMUX detected: not registering Nouveau backlight interface\n");
 		return 0;
 	}
 
-	INIT_LIST_HEAD(&drm->bl_connectors);
-
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS &&
 		    connector->connector_type != DRM_MODE_CONNECTOR_eDP)
