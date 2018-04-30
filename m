Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrQbgwuBJXeLDNy6pl3cPv464WG4TcjWnI+mwAkvIj8YgDUdoXcjIuL4lyG2euuZKIytLPc
ARC-Seal: i=1; a=rsa-sha256; t=1525116533; cv=none;
        d=google.com; s=arc-20160816;
        b=SjUFsnWughSTYKZLRxPVjciwrfFgRDAygPO344JVwPb35T481pdryhO1W+3o6IUJhB
         kF+k4nA+nI3DRVsjw0OKOu3TeylB8PuxgsmD0upVUXPbh03C7Xysye+A1PSZkmjsgL1A
         iZ4PQHIzdrZAgBLfQARmtPIjW76frSQjaReqR35PCusNxrqJ+CSHdDi+OOJQmJNdkkmL
         a6NHeqK5DbGf5RsWuMOGxDJuTLaQqYuqPQmWg/z6gW0kTpv9PT99Nptcha3iljJjheBq
         siP7n9fTbd2LJRg4GSyhtgsQ5y0wVhRUBAtIY/E3GfcrGjb6PhVy4FtQvSTz6uvNy8OP
         s3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ESD06QqtTclTr0igQrohbhDQ6Js4S2+jTkQs1Tot4BE=;
        b=qGDrGdMyKWCy9qRlTOQDQyrF8Iu/pT0OHhWE3cB/y1zukFAxzx8jHDr2gntZIm8NmX
         Sp7e/8a/LvL2oJNvAXGvyruQWIao0XgMS/ezvpwMGabzcjSy3IABB4c6yy/sSq1i/5zU
         DYAlN393dQ+6TFxbwaVNWVbjtrxvtTZyFTrTl7PUpzsa2k/VTYtlr/TQgyajnxC3EyXa
         N+jI2qZ7HqeTRiFpwl0S8oh30VC3hd9ORcs5JA5kQzTcamRpN7tp1roUIBBlXEM7vSMf
         0w+Th8hQg49lVH1vO8VPDVK8q0ljpATxwAH5eCuOb0B2hoKhVbB31S2VS0KefuA3Rhjz
         Q1Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1287522E72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Harry Wentland <harry.wentland@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 105/113] drm/amd/display: Disallow enabling CRTC without primary plane with FB
Date: Mon, 30 Apr 2018 12:25:16 -0700
Message-Id: <20180430184019.640588401@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200594434261335?=
X-GMAIL-MSGID: =?utf-8?q?1599200594434261335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit f2877656809386d7bc62c2b1c1b4e58404c486d4 upstream.

The below commit

    "drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2"

introduces a slight behavioral change to rmfb. Instead of disabling a crtc
when the primary plane is disabled, it now preserves it.

Since DC is currently not equipped to handle this we need to fail such
a commit, otherwise we might see a corrupted screen.

This is based on Shirish's previous approach but avoids adding all
planes to the new atomic state which leads to a full update in DC for
any commit, and is not what we intend.

Theoretically DM should be able to deal with states with fully populated planes,
even for simple updates, such as cursor updates. This should still be
addressed in the future.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Tested-by: Michel Dänzer <michel.daenzer@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4506,6 +4506,7 @@ static int dm_update_crtcs_state(struct
 		struct amdgpu_dm_connector *aconnector = NULL;
 		struct drm_connector_state *new_con_state = NULL;
 		struct dm_connector_state *dm_conn_state = NULL;
+		struct drm_plane_state *new_plane_state = NULL;
 
 		new_stream = NULL;
 
@@ -4513,6 +4514,13 @@ static int dm_update_crtcs_state(struct
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		acrtc = to_amdgpu_crtc(crtc);
 
+		new_plane_state = drm_atomic_get_new_plane_state(state, new_crtc_state->crtc->primary);
+
+		if (new_crtc_state->enable && new_plane_state && !new_plane_state->fb) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
 		aconnector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
 
 		/* TODO This hack should go away */
@@ -4685,7 +4693,7 @@ static int dm_update_planes_state(struct
 			if (!dm_old_crtc_state->stream)
 				continue;
 
-			DRM_DEBUG_DRIVER("Disabling DRM plane: %d on DRM crtc %d\n",
+			DRM_DEBUG_ATOMIC("Disabling DRM plane: %d on DRM crtc %d\n",
 					plane->base.id, old_plane_crtc->base.id);
 
 			if (!dc_remove_plane_from_context(
