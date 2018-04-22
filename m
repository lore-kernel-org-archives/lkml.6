Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+GVr4Uxt89NNr7kvkt1eCPCdJQWtJrtK+leF7IeNunvSXbRnB6o3/EEFKpRlFxXCE+Jhc/
ARC-Seal: i=1; a=rsa-sha256; t=1524405778; cv=none;
        d=google.com; s=arc-20160816;
        b=H1bEfibsdfjDPPkeNYnDr6MV1HuGCfHVryhboFsFcqd1oebkliF6iI34aLAI5UdzYm
         67COfZ5aOE27dIVNa0AZk2EWgbrcUVvleoJKoDmXnaqtJSNxw4e5odWiodWY8fvMopTN
         U2LcOYIz6yM/ut54qIS3jUSZcrEXCuggsIX6G7cS5nfhSbu2y3tSkJsvPRHpDUhjXhSp
         MDPyeD2ZMfIQ4IJAbiHgAPxBip92+r1iaga7vij/f5BoAKaBn/1vPM6o+sJSM/3FUuVw
         jwJVzhPj3h+9ICW0J/KqLTGzKneQugnAhgfGQr5XjXJKN8QtwN5AdaYq04c8+gBPvlnP
         4iPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3uJAgX7/ziS39aN2VtDuQkJeN1XilkDPym0bQn+KUmI=;
        b=A7+eKZfA0V+7aJr1DHB1GaYo93W1Zh3sBQzxnGduTUm4XlmOrfMXkoH63LqZ9Lpfkv
         xf8SKbFtFqo1HpBvTMh6I4nPq9yMkU7hxQRhkS6lXmpx6XbwgWdlO5ylOsLl3xdAYdtG
         d4KCsTdWLwrzfyB/ZCz0hT1NNPZUvVsPLeAvmtrZhLXn3MLidwc/O7+SnyUxQkK4Mwfg
         AsIRULCMejEAGvxmfo2nyBH1ey9hn/FU1YnoaaibvjQ1yfm6GhSUh9hkeWFq2wEMomln
         qdw0u1MnOe9gKj51sI+OsIJF33f8moRvmBtxy4SFHbL3KYwZNGSk9XZrAp7IsBHrJLww
         OjNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.16 190/196] libnvdimm, dimm: handle EACCES failures from label reads
Date: Sun, 22 Apr 2018 15:53:30 +0200
Message-Id: <20180422135114.075241881@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455313027068006?=
X-GMAIL-MSGID: =?utf-8?q?1598455313027068006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit e7c5a571a8d6a266aee9ca3f3f26e5afe3717eca upstream.

The new support for the standard _LSR and _LSW methods neglected to also
update the nvdimm_init_config_data() and nvdimm_set_config_data() to
return the translated error code from failed commands. This precision is
necessary because the locked status that was previously returned on
ND_CMD_GET_CONFIG_SIZE commands is now returned on
ND_CMD_{GET,SET}_CONFIG_DATA commands.

If the kernel misses this indication it can inadvertently fall back to
label-less mode when it should otherwise avoid all access to locked
regions.

Cc: <stable@vger.kernel.org>
Fixes: 4b27db7e26cd ("acpi, nfit: add support for the _LSI, _LSR, and...")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/dimm_devs.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -88,9 +88,9 @@ int nvdimm_init_nsarea(struct nvdimm_drv
 int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
+	int rc = validate_dimm(ndd), cmd_rc = 0;
 	struct nd_cmd_get_config_data_hdr *cmd;
 	struct nvdimm_bus_descriptor *nd_desc;
-	int rc = validate_dimm(ndd);
 	u32 max_cmd_size, config_size;
 	size_t offset;
 
@@ -124,9 +124,11 @@ int nvdimm_init_config_data(struct nvdim
 		cmd->in_offset = offset;
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
 				ND_CMD_GET_CONFIG_DATA, cmd,
-				cmd->in_length + sizeof(*cmd), NULL);
-		if (rc || cmd->status) {
-			rc = -ENXIO;
+				cmd->in_length + sizeof(*cmd), &cmd_rc);
+		if (rc < 0)
+			break;
+		if (cmd_rc < 0) {
+			rc = cmd_rc;
 			break;
 		}
 		memcpy(ndd->data + offset, cmd->out_buf, cmd->in_length);
@@ -140,9 +142,9 @@ int nvdimm_init_config_data(struct nvdim
 int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 		void *buf, size_t len)
 {
-	int rc = validate_dimm(ndd);
 	size_t max_cmd_size, buf_offset;
 	struct nd_cmd_set_config_hdr *cmd;
+	int rc = validate_dimm(ndd), cmd_rc = 0;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 
@@ -164,7 +166,6 @@ int nvdimm_set_config_data(struct nvdimm
 	for (buf_offset = 0; len; len -= cmd->in_length,
 			buf_offset += cmd->in_length) {
 		size_t cmd_size;
-		u32 *status;
 
 		cmd->in_offset = offset + buf_offset;
 		cmd->in_length = min(max_cmd_size, len);
@@ -172,12 +173,13 @@ int nvdimm_set_config_data(struct nvdimm
 
 		/* status is output in the last 4-bytes of the command buffer */
 		cmd_size = sizeof(*cmd) + cmd->in_length + sizeof(u32);
-		status = ((void *) cmd) + cmd_size - sizeof(u32);
 
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-				ND_CMD_SET_CONFIG_DATA, cmd, cmd_size, NULL);
-		if (rc || *status) {
-			rc = rc ? rc : -ENXIO;
+				ND_CMD_SET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
+		if (rc < 0)
+			break;
+		if (cmd_rc < 0) {
+			rc = cmd_rc;
 			break;
 		}
 	}
